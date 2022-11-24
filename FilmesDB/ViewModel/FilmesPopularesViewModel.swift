//
//  FilmesPopularesViewModel.swift
//  FilmesDB
//
//  Created by caiosouza on 05/10/22.
//

import UIKit

class FilmesPopularesViewModel: FilmeViewModel {
    var tituloSessao: String {
        return "Populares"
    }
    
    var tipo: FilmeViewModelType {
        return .populares
    }
    
    var filmes: [Filme] = []
    
    var numeroDeLinhas: Int {
        return filmes.count
    }
    
    //MARK: Inicializador
    
    init(_ filmes: [Filme]){
        self.filmes = filmes
    }
    
    init(_ filme: Filme){
        self.filmes.append(filme)
    }
    
    func adiciona(_ filmes: [Filme]){
        if(self.filmes.count > 0){
            self.filmes.append(contentsOf: filmes)
        }
    }
    
    func adiciona(_ filme: Filme){
        self.filmes.append(filme)
    }


}
