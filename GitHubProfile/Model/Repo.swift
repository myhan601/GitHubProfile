//
//  Repo.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import Foundation

struct Repo: Decodable {
    let repoName: String
    let devLangName: String?
    
    enum CodingKeys: String, CodingKey {
        case repoName = "name"
        case devLangName = "language"
    }
}


