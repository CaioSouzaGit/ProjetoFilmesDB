//
//  FavoritosViewController.swift
//  FilmesDB
//
//  Created by caiosouza on 21/11/22.
//

import UIKit

class FavoritosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Atributos
    var filmeSelecionado: Filme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTableView()
        // Do any additional setup after loading the view.
    }
    
    func configuraTableView(){
        tableView.register(UINib(nibName: "FilmePopularTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmePopularTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.delegate = self
    }
    
    func irParaFilmePopularDetalhe(_ filme: Filme?){
        if let filmeSelecionado = filme {
            let filmePopularController = FilmePopularViewController.instanciar(filmeSelecionado)
            navigationController?.pushViewController(filmePopularController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 640 : 675
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(Sessao.filmesFavoritos == nil || Sessao.filmesFavoritos?.filmes.count == 0){
            return 0
        }
        if let qtdFilmesFavoritos = Sessao.filmesFavoritos?.numeroDeLinhas {
            return qtdFilmesFavoritos
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = Sessao.filmesFavoritos
        
        guard let celula = tableView.dequeueReusableCell(withIdentifier: "FilmePopularTableViewCell") as? FilmePopularTableViewCell else {
            fatalError("Erro ao criar FilmePopularTableViewCell")
        }
        celula.configuraCelula(viewModel?.filmes[indexPath.row])
        return celula
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewModel = Sessao.filmesFavoritos
        
        switch viewModel?.tipo {
        case .populares:
            filmeSelecionado = viewModel?.filmes[indexPath.row]
            irParaFilmePopularDetalhe(filmeSelecionado)
            break
        default:
            break
        }
    }

    @IBAction func botaoVoltar(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
