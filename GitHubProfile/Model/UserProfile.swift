//
//  UserProfile.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import Foundation

struct UserProfile: Decodable {
    var login: String
    var avatarUrl: String
    var followers: Int
    var following: Int
    
    // API에서 반환되는 JSON 필드와 다를 경우, CodingKeys를 사용하여 매핑
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case followers
        case following
    }
}
