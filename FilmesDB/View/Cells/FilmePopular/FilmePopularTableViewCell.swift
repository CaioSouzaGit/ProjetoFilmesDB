//
//  FilmePopularTableViewCell.swift
//  FilmesDB
//
//  Created by caiosouza on 06/10/22.
//

import UIKit

class FilmePopularTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var NomeFilmeLabel: UILabel!
    @IBOutlet weak var DataFilmeLabel: UILabel!
    @IBOutlet weak var ImagemFilmeLabel: UIImageView!
    
    func configuraCelula(_ filme: Filme?){
        guard let nomeImagem = filme?.poster_path else { return }
        ImagemFilmeLabel.load(urlString: "https://image.tmdb.org/t/p/original\(nomeImagem)")
    }
}


