//
//  ViewController.swift
//  AluraViagens
//
//  Created by caiosouza on 20/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var filmesTableView: UITableView!
    
    
    //MARK: Atributos
    var filmeSelecionado: Filme?
    var frameSelecionado: CGRect?
    var pagina: Int = 1
    var ultimaSectionAtual: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obterDados()
        obterFilmesFavoritos()
        configuraTableView()
    }
    
    func configuraTableView(){
        filmesTableView.register(UINib(nibName: "FilmePopularTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmePopularTableViewCell")
        filmesTableView.dataSource = self
        filmesTableView.delegate = self
        navigationController?.delegate = self
        view.backgroundColor = UIColor(red: 252.0/255.0, green: 68.0/255.0, blue: 20.0/255.0, alpha: 1)
    }
    
    func irParaFilmePopularDetalhe(_ filme: Filme?){
        if let filmeSelecionado = filme {
            let filmePopularController = FilmePopularViewController.instanciar(filmeSelecionado)
            navigationController?.pushViewController(filmePopularController, animated: true)
        }
    }
    
    private func obterDados(_ section: Int = 0, completed: ((Bool) -> Void)? = nil) {
        FilmesAPI.shared.buscarFilmesPopulares(page: pagina, sucesso: {(FilmesPopulares) in
            self.pagina+=1
            guard let filmesPopulares = FilmesPopulares.results else { return }
            
            if(Sessao.filmes?.count == 0 || Sessao.filmes?[section].numeroDeLinhas == 0){
                Sessao.filmes?.insert(FilmesPopularesViewModel(filmesPopulares), at: 0)
            }else{
                Sessao.filmes?[section].filmes.append(contentsOf: filmesPopulares)
            }
            DispatchQueue.main.async {
                self.filmesTableView.reloadData()
            }
            
            completed?(true)
        }, falha: {(Error) in print(Error.localizedDescription);
            completed?(false)})
    }
    
    private func obterFilmesFavoritos(){
        Sessao.filmesFavoritos = FilmesPopularesViewModel(FilmeDao().recupera())
    }
    
    @IBAction func botaoIrParaTopo(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        filmesTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (Sessao.filmes == nil || Sessao.filmes?.count == 0) {
            return 0
        }
        guard let filmes = Sessao.filmes?[section] else { return 0 }
        return filmes.numeroDeLinhas
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = Sessao.filmes?[indexPath.section]
        
        switch viewModel?.tipo {
            case .populares:
                guard let celula = tableView.dequeueReusableCell(withIdentifier: "FilmePopularTableViewCell") as? FilmePopularTableViewCell else {
                    fatalError("Erro ao criar FilmePopularTableViewCell")
                }
                celula.configuraCelula(viewModel?.filmes[indexPath.row])
                return celula
            default:
                return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let numeroDeLinhas = Sessao.filmes?[indexPath.section].numeroDeLinhas else {return}
        
        if indexPath.row == (numeroDeLinhas - 1) {
            print("load new data..")
            obterDados(indexPath.section) { [weak self] success in
                if !success {
                    print("deu ruim");
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewModel = Sessao.filmes?[indexPath.section]
        
        switch viewModel?.tipo {
        case .populares:
            filmeSelecionado = viewModel?.filmes[indexPath.row]
            frameSelecionado = tableView.rectForRow(at: indexPath)
            irParaFilmePopularDetalhe(filmeSelecionado)
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self, options: nil)?.first as? HomeTableViewHeader
            headerView?.configuraView()
            headerView?.delegate = self
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 300
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 640 : 675
    }
}

extension ViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let caminhoDaImagem = filmeSelecionado?.poster_path else {return nil}
        guard let imagem = UIImage(named: caminhoDaImagem) else {return nil}
        guard let frame = frameSelecionado else { return nil }
        
        switch operation {
        case .push:
            return AnimacaoTransicaoPersonalizada(duracao: TimeInterval(UINavigationController.hideShowBarDuration), imagem: imagem, frameInicial: frame, apresentarViewController: true)
        default:
            return AnimacaoTransicaoPersonalizada(duracao: TimeInterval(UINavigationController.hideShowBarDuration), imagem: imagem, frameInicial: frame, apresentarViewController: false)
        }
    }
}

extension ViewController: HomeTableViewHeaderDelegate {
    
    func irParaFavoritos() {
        if let filmesFavoritos = Sessao.filmesFavoritos {
            //let filmePopularController = FilmePopularViewController.instanciar(filmeSelecionado)
            let filmePopularViewController = FavoritosViewController(nibName: "FavoritosViewController", bundle: nil)
            navigationController?.pushViewController(filmePopularViewController, animated: true)
        }
    }
}
