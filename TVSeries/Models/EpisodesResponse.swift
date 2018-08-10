//
//  EpisodesResponse.swift
//  TVSeries
//
//  Created by Selin Ersev on 10.08.2018.
//  Copyright © 2018 Selin Ersev. All rights reserved.
//

import UIKit
import Foundation

struct Episodes: Codable {
    let id: Int?
    let url, name: String?
    let season, number: Int?
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let image: Image?
    let summary: String?
    let links: Link?
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, airdate, airtime, airstamp, runtime, image, summary
        case links = "_links"
    }
}


struct Link: Codable {
    let linksSelf: SelfClass?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

struct SelfClass: Codable {
    let href: String?
}
