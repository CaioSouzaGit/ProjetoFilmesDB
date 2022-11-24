//
//  FilmeViewModel.swift
//  FilmesDB
//
//  Created by caiosouza on 20/09/22.
//

import UIKit

enum FilmeViewModelType: String {
    case populares

}

protocol FilmeViewModel {
    var tituloSessao: String { get }
    var tipo: FilmeViewModelType { get }
    var filmes: [Filme] { get set }
    var numeroDeLinhas: Int { get }
    
    func adiciona(_ filmes: [Filme])
    func adiciona(_ filme: Filme)
}
