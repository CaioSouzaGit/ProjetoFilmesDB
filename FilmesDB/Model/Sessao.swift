//
//  Sessao.swift
//  FilmesDB
//
//  Created by caiosouza on 22/11/22.
//

import Foundation

struct Sessao {
    static var filmes: [FilmeViewModel]? = []
    static var generos: [Genero]? = []
    static var filmesFavoritos: FilmeViewModel?
    static var idioma: String = "pt-BR"
}
