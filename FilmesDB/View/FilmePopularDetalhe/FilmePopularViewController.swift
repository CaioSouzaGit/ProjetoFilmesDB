//
//  FilmePopularViewController.swift
//  FilmesDB
//
//  Created by caiosouza on 19/11/22.
//

import UIKit
import YoutubePlayer_in_WKWebView

class FilmePopularViewController: UIViewController, WKYTPlayerViewDelegate {
    
    
    //Mark: IBOutlets
    @IBOutlet weak var nomeFilmeLabel: UILabel!
    @IBOutlet weak var dataLancamentoFilmeLabel: UILabel!
    @IBOutlet weak var generosFilmeLabel: UILabel!
    @IBOutlet weak var descricaoFilmeLabel: UILabel!
    @IBOutlet weak var filmeImagem: UIImageView!
    @IBOutlet weak var botaoFavorito: UIButton!
    @IBOutlet weak var videoPlayer: WKYTPlayerView!
    
    
    //MARK: Atributos
    var filme: Filme?
    var video: Video?
    
    
    //MARK: View Life Cycle
    class func instanciar(_ filme: Filme) -> FilmePopularViewController {
        let filmePopularViewController = FilmePopularViewController(nibName: String(describing: Self.self), bundle: nil)
        filmePopularViewController.filme = filme
        
        return filmePopularViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView()
        guard let filme = filme else {return}
        FilmesAPI.shared.buscarVideo(filmeId: filme.id, tipo: "Trailer", site: "YouTube", sucesso: {(video) in
            self.video = video
            self.configuraPlayer()
        }, falha: {(Error) in print(Error.localizedDescription)})
        
        
    }
    
    func configuraPlayer(){
        guard let video = video else {return}
        DispatchQueue.main.async {
            self.videoPlayer.load(withVideoId: video.key)
        }
    }
    
    func configuraView(){
        guard let nomeImagem = filme?.backdrop_path else { return }
        guard let generosIds = filme?.genre_ids else {return}
        guard let generosSessao = Sessao.generos else {return}
        guard var dataLancamento = filme?.release_date else {return}
        
        filmeImagem.load(urlString: "https://image.tmdb.org/t/p/original\(nomeImagem)")
        nomeFilmeLabel.text = filme?.title
        dataLancamento.obterData(data: dataLancamento)
        dataLancamentoFilmeLabel.text? = "Data de Lançamento: \(dataLancamento)"
        
        //TODO: Usar dicionario para melhor complexidade
        var tempGenero: String = "Gêneros: "
        for generoId in generosIds {
            for genero in generosSessao {
                if(generoId == genero.id){
                    tempGenero.append("\(genero.name), ")
                }
            }
        }
        tempGenero.removeLast(2)
        generosFilmeLabel.text = tempGenero
        descricaoFilmeLabel.text = filme?.overview
        
        botaoFavorito.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        botaoFavorito.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal), for: .selected)
        
        if let numeroFavoritos = Sessao.filmesFavoritos?.numeroDeLinhas, numeroFavoritos > 0 {
            if let filmesFavoritos = Sessao.filmesFavoritos?.filmes {
                if (filmesFavoritos.contains(where: {$0.id == filme?.id})){
                    botaoFavorito.isSelected.toggle()
                }
            }            
        }
    }

    @IBAction func botaoVoltar(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func botaoFavoritar(_ sender: Any) {
        guard let filme = filme else {return}
        
        
        if (!botaoFavorito.isSelected){
            if (Sessao.filmesFavoritos == nil) {
                Sessao.filmesFavoritos = FilmesPopularesViewModel(filme)
            }else {
                Sessao.filmesFavoritos?.adiciona(filme)
            }
        }else{
            if (Sessao.filmesFavoritos == nil){
                return;
            }
            Sessao.filmesFavoritos?.filmes.removeAll(where: {$0.id == filme.id})
        }
        
        if let filmesFavoritos = Sessao.filmesFavoritos?.filmes {
            FilmeDao().save(filmesFavoritos)
        }
        
        botaoFavorito.isSelected = !botaoFavorito.isSelected
    }
}
