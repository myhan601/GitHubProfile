//
//  Repo.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import Foundation

struct Repo {
    let repoName: String
    let devLangName: String
}

extension Repo {
    static let sampleData: [Repo] = [
        Repo(repoName: "GitHubRepository", devLangName: "Swift")
    ]
}
