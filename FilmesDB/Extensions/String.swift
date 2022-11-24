//
//  String.swift
//  FilmesDB
//
//  Created by caiosouza on 20/11/22.
//

import Foundation
import UIKit


extension String {
    
    mutating func obterData(data: String) {
        let dateFormatter = DateFormatter()
        let dateFormatterConvertido = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatterConvertido.dateFormat = "dd/MM/yyyy"
        guard let dataFormatada = dateFormatter.date(from: data) else {return}
        self = dateFormatterConvertido.string(from: dataFormatada)
    }
}
