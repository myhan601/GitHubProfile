//
//  RepoManager.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import Foundation
import Alamofire

class RepoManager {
    func fetchRepos(for username: String, completion: @escaping (Result<[Repo], AFError>) -> Void) {
        let url = "https://api.github.com/users/\(username)/repos"
        
        AF.request(url, method: .get).responseDecodable(of: [Repo].self) { response in
            completion(response.result)
        }
    }
}


