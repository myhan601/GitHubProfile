//
//  ViewController.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var repoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 셀 등록
        let nib = UINib(nibName: "RepoTableViewCell", bundle: nil)
        repoTableView.register(nib, forCellReuseIdentifier: "RepoTableViewCell")
        
        repoTableView.delegate = self
        repoTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Repo.sampleData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
            
            cell.setData(Repo.sampleData[indexPath.row])
            
            return cell
        }
}
