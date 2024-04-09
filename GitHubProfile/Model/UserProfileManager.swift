//
//  UserProfileManager.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import Foundation
import Alamofire

class UserProfileManager {
    func fetchUserProfile(for username: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let urlString = "https://api.github.com/users/\(username)"
        AF.request(urlString).responseDecodable(of: UserProfile.self) { response in
            switch response.result {
            case .success(let userProfile):
                completion(.success(userProfile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
