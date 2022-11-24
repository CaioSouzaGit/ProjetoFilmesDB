//
//  Filme.swift
//  FilmesDB
//
//  Created by caiosouza on 20/09/22.
//

import UIKit

struct FilmesPopulares: Decodable {
    let results: [Filme]?
}

class Filme: NSObject, Decodable, NSCoding, NSSecureCoding {
       
    static var supportsSecureCoding: Bool = true
    
    //var adult: Bool
    var backdrop_path: String?
//    var budget: Int
    //var homepage: String?
    var id: Int
    //var imdb_id: String?
    //var original_language: String
    //var original_title: String
    var overview: String?
    //var popularity: Double
    var poster_path: String?
    var release_date: String
    var genre_ids: [Int]?
//    var revenue: Int
    //var runtime: Int?
//    var status: String
    //var tagline: String?
    var title: String?
    //var video: Bool
    //var vote_average: Double
    //var vote_count: Double
    
    init(backdrop_path: String?,
         id: Int,
         overview: String?,
         poster_path: String?,
         release_date: String,
         genre_ids: [Int]?,
         title: String) {
        self.backdrop_path = backdrop_path
        self.id = id
        self.overview = overview
        self.poster_path = poster_path
        self.release_date = release_date
        self.genre_ids = genre_ids
        self.title = title
    }
    
    
    //MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(backdrop_path, forKey: "backdrop_path")
        coder.encode(id, forKey: "id")
        coder.encode(overview, forKey: "overview")
        coder.encode(poster_path, forKey: "poster_path")
        coder.encode(release_date, forKey: "release_date")
        coder.encode(genre_ids, forKey: "genre_ids")
        coder.encode(title, forKey: "title")
    }
    
    required init?(coder: NSCoder) {
        backdrop_path = coder.decodeObject(forKey: "backdrop_path") as? String
        id = coder.decodeInteger(forKey: "id")
        overview = coder.decodeObject(forKey: "overview") as? String
        poster_path = coder.decodeObject(forKey: "poster_path") as? String
        release_date = coder.decodeObject(forKey: "release_date") as! String
        genre_ids = coder.decodeArrayOfObjects(ofClass: NSNumber.self, forKey: "genre_ids") as? [Int]
        title = coder.decodeObject(forKey: "title") as? String
    }

    
}
