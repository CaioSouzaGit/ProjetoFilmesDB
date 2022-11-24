//
//  Genre.swift
//  FilmesDB
//
//  Created by caiosouza on 19/11/22.
//

import UIKit

struct Generos: Decodable{
    let genres: [Genero]?
}

struct Genero: Decodable{
    var id: Int
    var name: String
}
