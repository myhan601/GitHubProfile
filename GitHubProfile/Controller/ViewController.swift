//
//  ViewController.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    var repos: [Repo] = [] // Repo 타입의 배열
    let username = "myhan601"

    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId.text = username
        // 셀 등록
        let nib = UINib(nibName: "RepoTableViewCell", bundle: nil)
        repoTableView.register(nib, forCellReuseIdentifier: "RepoTableViewCell")
        
        repoTableView.delegate = self
        repoTableView.dataSource = self
        
        fetchRepos(for: username)
        fetchUserProfile()
    }
    
    func fetchUserProfile() {
        let urlString = "https://api.github.com/users/\(username)"
        AF.request(urlString).responseJSON { [weak self] response in
            if let data = response.data {
                do {
                    // JSON 디코딩
                    let user = try JSONDecoder().decode(UserProfile.self, from: data)
                    // 프로필 이미지 URL 로드
                    if let profileImageUrl = URL(string: user.avatarUrl) {
                        DispatchQueue.main.async {
                            self?.profileImage.kf.setImage(with: profileImageUrl)
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func fetchRepos(for username: String) {
        let repoManager = RepoManager()
        repoManager.fetchRepos(for: username) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.repos = repos
                DispatchQueue.main.async {
                    self?.repoTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
            
            cell.setData(repos[indexPath.row])
            
            return cell
        }
}
