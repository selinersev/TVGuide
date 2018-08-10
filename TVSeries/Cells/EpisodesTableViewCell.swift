//
//  EpisodesTableViewCell.swift
//  TVSeries
//
//  Created by Selin Ersev on 10.08.2018.
//  Copyright © 2018 Selin Ersev. All rights reserved.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {

    @IBOutlet weak var airDate: UILabel!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var summary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
