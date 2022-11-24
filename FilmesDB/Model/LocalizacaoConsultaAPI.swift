//
//  LocalizacaoConsultaAPI.swift
//  SinqiaViagens
//
//  Created by caiosouza on 12/09/22.
//

import UIKit
import Alamofire

class LocalizacaoConsultaAPI: NSObject {

    func consultaViaCepApi(cep: String, sucesso: @escaping(_ localizacao: Localizacao) -> Void, falha: @escaping(_ error: Error) -> Void
    ){
        let url = "https://viacep.com.br/ws/\(cep)/json/"
        let request = AF.request(url)
        request.validate().responseJSON { (data) in
            //print(data)
            switch data.result {
                case .success:
                if let resultado = data.value as? Dictionary<String, String> {
                    let localizacao = Localizacao(resultado)
                    sucesso(localizacao)
                }
                break
            case .failure:
                falha(data.error!)
                break
                
            }
            
        }
    }
}
