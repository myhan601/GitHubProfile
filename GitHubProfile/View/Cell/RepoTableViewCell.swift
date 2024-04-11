//
//  TableViewCell.swift
//  GitHubProfile
//
//  Created by 한철희 on 4/9/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "RepoTableViewCell"

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var devLanguageName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ repoData: Repo){
        repoNameLabel.text = repoData.repoName
        devLanguageName.text = repoData.devLangName
    }
}
