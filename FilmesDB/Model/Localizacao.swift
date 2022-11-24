//
//  Localizacao.swift
//  SinqiaViagens
//
//  Created by caiosouza on 07/09/22.
//

import UIKit

class Localizacao: NSObject {

    var logradouro = ""
    var bairro = ""
    var cidade = ""
    var uf = ""
    
    init(_ dicionario: Dictionary<String, String>){
        logradouro = dicionario["logradouro"] ?? ""
        bairro = dicionario["bairro"] ?? ""
        cidade = dicionario["cidade"] ?? ""
        uf = dicionario["uf"] ?? ""
    }
}
