//
//  ViewController.swift
//  TVSeries
//
//  Created by Selin Ersev on 7.08.2018.
//  Copyright © 2018 Selin Ersev. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire


class ViewController: UIViewController {
    var series = [Series]()
    var page = 0
    var isLoading = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true
        self.title = "TV Series"
        fetch()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetch(page:Int = 0) {
        isLoading = true
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let url = URL(string:"http://api.tvmaze.com/shows?page=\(page)")!
        Alamofire.request(url).responseDecodableObject( decoder: decoder) { (response: DataResponse<[Series]>) in

            if response.error != nil {
                print(response.error)
                guard let responseData = response.data else {return}
                print(String(data: responseData, encoding: String.Encoding.utf8))
            }else{
                let array = response.result.value ?? []
                array.forEach{show in
                    self.series.append(show)
                }
            }
            
            
            self.tableView.reloadData()
            self.isLoading = false
        }

        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoShow"{
            let controller = segue.destination as! InfoViewController
            guard let selected = sender as? Series else{return}
            controller.series = selected

            
        }
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return series.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seriesCell", for: indexPath) as! SeriesTableViewCell

        cell.populate(with: series[indexPath.row])
        return cell
    }

}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "InfoShow", sender: self.series[indexPath.row])
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + self.tableView.frame.size.height > scrollView.contentSize.height - 200 {
            guard !isLoading else {return}
            page += 1
            fetch(page: page)
        }
    }
}
