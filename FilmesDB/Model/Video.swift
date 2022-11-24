//
//  Video.swift
//  FilmesDB
//
//  Created by caiosouza on 22/11/22.
//

import Foundation

struct Videos: Decodable {
    let id: Int
    let results: [Video]?
}

class Video: Decodable {
    var name: String
    var key: String
    var site: String
    var type: String
}
