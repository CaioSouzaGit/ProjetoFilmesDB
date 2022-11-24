//
//  HomeTableViewHeader.swift
//  AluraViagens
//
//  Created by caiosouza on 20/07/22.
//

import UIKit

protocol HomeTableViewHeaderDelegate: AnyObject {
    func irParaFavoritos()
}

class HomeTableViewHeader: UIView {

    //MARK: IBOutlets    
    @IBOutlet weak var tituloLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var bannerImageView: UIImageView!

    @IBOutlet weak var bannerView: UIView!
    
    //MARK: Attributos
    weak var delegate: HomeTableViewHeaderDelegate?
    
    func configuraView(){
       headerView.backgroundColor = UIColor(red: 252.0/255.0, green: 68.0/255.0, blue: 20.0/255.0, alpha: 1)
        bannerView.layer.cornerRadius = 10
        bannerView.layer.masksToBounds = true
        
        headerView.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 500 : 200;
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    @IBAction func irParaFavoritos(_ sender: Any) {
        //navigationController?.delegate = self
        delegate?.irParaFavoritos()
    }
    
}
