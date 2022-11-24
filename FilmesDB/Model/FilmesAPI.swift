//
//  FilmesAPI.swift
//  FilmesDB
//
//  Created by caiosouza on 21/09/22.
//

import UIKit

struct FilmesAPI {
    static let shared = FilmesAPI()
    var apiKey: String = "ced2110fe6163b234b71765afd16ef58"
    var idioma: String = "pt-BR"
    
    func buscarFilmesPopulares(page: Int = 1, sucesso: @escaping(_ filmes: FilmesPopulares) ->
          Void, falha: @escaping(_ error: Error) -> Void
    ){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=\(page)&language=\(idioma)") else{
                return
            }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data{
                do{
                    let filmes = try decoder.decode(FilmesPopulares.self, from: data)
                    buscarGeneros(sucesso: {(generos) in
                        Sessao.generos = generos
                    }, falha: {(Error) in print(Error.localizedDescription)})
                    sucesso(filmes)
                }catch{
                    falha(error)
                }
            }
        }
        task.resume()
    }
    
    func buscarGeneros(sucesso: @escaping(_ generos: [Genero]?) -> Void, falha: @escaping(_ error: Error) -> Void
    ){
        guard let urlGeneros = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=\(idioma)") else { return }
        
        let task = URLSession.shared.dataTask(with: urlGeneros){
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let generos = try decoder.decode(Generos.self, from: data)
                    sucesso(generos.genres)
                }catch{
                    falha(error)
                }
                
            }
        }
        task.resume()
    }
    
    func buscarVideos(filmeId: Int, sucesso: @escaping(_ videos: [Video]?) -> Void, falha: @escaping(_ error: Error) -> Void
    ){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(filmeId)/videos?api_key=\(apiKey)&language=\(idioma)") else { return }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let videos = try decoder.decode(Videos.self, from: data)
                    sucesso(videos.results)
                }catch{
                    falha(error)
                }
                
            }
        }
        task.resume()
    }
    
    func buscarVideo(filmeId: Int, tipo: String, site: String, sucesso: @escaping(_ video: Video?) -> Void, falha: @escaping(_ error: Error) -> Void
    ){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(filmeId)/videos?api_key=\(apiKey)&language=\(idioma)") else { return }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let videos = try decoder.decode(Videos.self, from: data)
                    sucesso(videos.results?.first(where: {$0.type == tipo && $0.site == site}))
                }catch{
                    falha(error)
                }
                
            }
        }
        task.resume()
    }
}
