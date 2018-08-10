//
//  SeriesTableViewCell.swift
//  TVSeries
//
//  Created by Selin Ersev on 7.08.2018.
//  Copyright © 2018 Selin Ersev. All rights reserved.
//

import UIKit
import Kingfisher
import FaceAware

class SeriesTableViewCell: UITableViewCell {

    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var premiereDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populate(with series: Series){
        seriesName.text = series.name
        languageLabel.text = series.language
        premiereDateLabel.text = series.premiered
        
        guard let x = series.image?.medium else {
            seriesImage.image = UIImage()
            return}
        if let url = URL(string: x){
            seriesImage.kf.setImage(with: url, placeholder: UIImage(), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                self.seriesImage.clipsToBounds = true
                self.seriesImage.focusOnFaces = true
                
            }
        
        }
        
    }
}
