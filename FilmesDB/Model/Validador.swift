//
//  Validador.swift
//  SinqiaViagens
//
//  Created by caiosouza on 09/08/22.
//

import UIKit
import CPF_CNPJ_Validator


enum TiposDeTextField: Int {
    case nomeCompleto = 0
    case email = 1
    case cpf = 2
    case cep = 3
    case endereco = 4
    case bairro = 5
    case numeroDoCartao = 6
    case mesDeVencimento = 7
    case anoDeVencimento = 8
    case codigoDeSeguranca = 9
    case numeroDeParcelas = 10
}

class Validador: NSObject {

    func validaTextFields(_ textFields: [UITextField?]) -> Bool {
        for textField in textFields {
            if textField?.text == "" {
                chacoalhar(textField)
                return false
            }
        }
        return true
    }
    
    func chacoalhar(_ textField: UITextField?){
        guard let textField = textField else {
            return
        }
        let chacoalhar = CABasicAnimation(keyPath: "position")
        
        chacoalhar.duration = 0.1
        chacoalhar.repeatCount = 2
        chacoalhar.autoreverses = true
        
        let posicaoInicial = CGPoint(x: textField.center.x + 5, y: textField.center.y)
        let posicaoFinal = CGPoint(x: textField.center.x - 5, y: textField.center.y)
        
        chacoalhar.fromValue = posicaoInicial
        chacoalhar.toValue = posicaoFinal
        
        textField.layer.add(chacoalhar, forKey: nil)
    }
    
    func exibeNotificacaoDePreenchimentoDosTextFields(titulo: String, mensagem: String) -> UIAlertController {
        let notificacao = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let botao = UIAlertAction(title: "Ok", style: .default, handler: nil)
        notificacao.addAction(botao)
        
        return notificacao
    }
    
    func verificaTextFieldsValidos(listaDeTextFields: [UITextField]) -> Bool{
        var dicionarioDeTextFields: Dictionary<TiposDeTextField, UITextField> = [:]
        
        for textField in listaDeTextFields {
            if let tipoTextField = TiposDeTextField(rawValue: textField.tag) {
                dicionarioDeTextFields[tipoTextField] = textField
            }
        }
        
        guard let cpf = dicionarioDeTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text! ) else { return false }
        
        guard let email = dicionarioDeTextFields[.email], self.verificaEmail(email.text!) else { return false }
        
        return true
    }
    
    func verificaEmail(_ email: String) -> Bool{
        let emailRegex = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
        
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        
        return emailTest.evaluate(with: email)
    }
}
