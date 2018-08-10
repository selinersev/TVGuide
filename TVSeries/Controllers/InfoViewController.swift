//
//  InfoViewController.swift
//  TVSeries
//
//  Created by Selin Ersev on 7.08.2018.
//  Copyright © 2018 Selin Ersev. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire

class InfoViewController: UIViewController {
    var series: Series?
    var episodes = [Episodes]()
    var episodesDictionary: Dictionary = [Int: [Episodes]]()
    var seasons = [Int]()
    
    @IBOutlet weak var seasonsTableView: UITableView!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        seasonsTableView.estimatedRowHeight = 150
        seasonsTableView.rowHeight = UITableViewAutomaticDimension
        seriesImage.kf.setImage(with: URL(string: (series?.image?.original)!)!)
        nameLabel.text = series?.name
        let stringRep = series?.genres?.joined(separator: ",")
        genreLabel.text = stringRep
        fetch(id: (series?.id)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addDictionary(){

        episodes.forEach{ episode in
            guard let season = episode.season, !seasons.contains(season) else {return}
            seasons.append(season)
            
        }
        seasons.forEach{ season in
            episodesDictionary[season] = episodes.filter {$0.season == season}
        }
        seasonsLabel.text = "\(seasons.count) Seasons"
        
        seasonsTableView.reloadData()
    }
    func fetch(id: Int){
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let url = URL(string:"http://api.tvmaze.com/shows/\(id)/episodes")!
        Alamofire.request(url).responseDecodableObject( decoder: decoder) { (response: DataResponse<[Episodes]>) in
            
            if response.error != nil {
                print(response.error)
                
                
            }else{
                guard let responseData = response.data else {return}
                
                self.episodes = response.result.value ?? []
                self.addDictionary()
                
            }
        }
    }
}

extension InfoViewController: UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodesTableViewCell
        let season = episodesDictionary[seasons[indexPath.section]]
        let episode = season![indexPath.row]
        cell.airDate.text = episode.airdate
        cell.episodeName.text = episode.name
        guard let x = episode.image?.medium else {return UITableViewCell()}
        if let url = URL(string: x){
            cell.episodeImage.kf.setImage(with: url, placeholder: UIImage(), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                cell.episodeImage.clipsToBounds = true
            }
        }
        let text = episode.summary?.dropFirst(3).dropLast(4)
        cell.summary.text = String(text!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return episodesDictionary[seasons[section]]!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodesDictionary.keys.count
    }

    
}
extension InfoViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! CustomHeaderCell
        headerCell.headerLabel.text = "Season \(seasons[section])"
        return headerCell
    }

}






