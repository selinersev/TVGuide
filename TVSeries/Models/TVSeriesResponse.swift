// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import UIKit

import Foundation

struct Series: Codable {
    let id: Int?
    let url, name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let premiered, officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, premiered, officialSite, schedule, rating, weight, externals, image, summary, updated
        case links = "_links"
    }
}

struct Externals: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

struct Image: Codable {
    let medium, original: String?
}


struct Links: Codable {
    let linksSelf, previousepisode, nextepisode: Nextepisode?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

struct Nextepisode: Codable {
    let href: String?
}

struct Network: Codable {
    let id: Int?
    let name: String?
    let country: Country?
}

struct Country: Codable {
    let name: String?
    let code: String?
    let timezone: String?
}

struct Rating: Codable {
    let average: Double?
}

struct Schedule: Codable {
    let time: String?
    let days: [String]?
}



