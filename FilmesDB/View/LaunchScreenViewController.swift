//
//  LaunchScreenViewController.swift
//  SinqiaViagens
//
//  Created by caiosouza on 10/08/22.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var constraintTituloTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaAnimacao()
    }

    //MARK: Metodos
    
    func iniciaAnimacao(){
        constraintTituloTop.constant = 280
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        }) { (_ ) in
            self.irParaHome()
        }
    }
    
    func irParaHome(){
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home")
        let navigation = UINavigationController(rootViewController: home)
        navigation.modalPresentationStyle = .fullScreen
        navigation.setNavigationBarHidden(true, animated: false)
        present(navigation, animated: true, completion: nil)
    }
}
