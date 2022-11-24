//
//  FilmeDao.swift
//  FilmesDB
//
//  Created by caiosouza on 20/11/22.
//

import Foundation

class FilmeDao {
    
    let pasta = "filmesFavoritos"
    
    func save(_ itens: [Filme]){
        guard let caminho = recuperaDiretorio() else { return }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperaDiretorio() -> URL? {
        
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let caminho = diretorio.appendingPathComponent(pasta)
        
        return caminho
    }
    
    func recupera() -> [Filme] {
        guard let caminho = recuperaDiretorio() else { return [] }
        
        do {
            let dados = try Data(contentsOf: caminho)
            guard let itenssalvos = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClasses: [Filme.self, NSString.self, NSNumber.self], from: dados) else { return [] }
            return itenssalvos as! [Filme]
            
        }catch {
            print(error.localizedDescription)
            return []
        }
    }
}
