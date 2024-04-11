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
    
    let repoManager = RepoManager()
    var repos: [Repo] = [] // Repo 타입의 배열
    let username = "myhan601"
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId.text = username
        // 셀 등록
        let nib = UINib(nibName: "RepoTableViewCell", bundle: nil)
        repoTableView.register(nib, forCellReuseIdentifier: "RepoTableViewCell")
        
        repoTableView.delegate = self
        repoTableView.dataSource = self
        
        fetchRepos(for: username)
        updateUserProfileUI(for: username)
        
        // refreshControl에 액션 추가
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // tableView의 refreshControl로 지정
        repoTableView.refreshControl = refreshControl
    }
    
    func updateUserProfileUI(for username: String) {
        let userProfileManager = UserProfileManager()
        userProfileManager.fetchUserProfile(for: username) { [weak self] result in
            switch result {
            case .success(let userProfile):
                DispatchQueue.main.async {
                    // 프로필 이미지 업데이트
                    if let profileImageUrl = URL(string: userProfile.avatarUrl) {
                        self?.profileImage.kf.setImage(with: profileImageUrl)
                    }
                    // 팔로워 수 업데이트
                    self?.followersLabel.text = "Followers: \(userProfile.followers)"
                    // 팔로잉 수 업데이트
                    self?.followingLabel.text = "Following: \(userProfile.following)"
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    @objc func refreshData() {
        // 필요한 데이터를 새로 고침
        fetchRepos(for: username)
        updateUserProfileUI(for: username)
        
        // 1초 딜레이 후 리프레쉬 종료
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1초 딜레이
            self.refreshControl.endRefreshing()
        }
    }
    
    func fetchRepos(for username: String) {
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
