//
//  UserProfile.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import Foundation

struct UserProfile: Decodable {
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}
