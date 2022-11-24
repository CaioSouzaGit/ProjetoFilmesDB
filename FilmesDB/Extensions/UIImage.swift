//
//  UIImage.swift
//  FilmesDB
//
//  Created by caiosouza on 19/11/22.
//

import Foundation
import UIKit


func compressImage(image: UIImage) -> UIImage {
        let resizedImage = image.aspectFittedToHeight(640)
        resizedImage.jpegData(compressionQuality: 0.2)
    
        return resizedImage
}

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let lowerQualityImage = compressImage(image: image)
                        self?.image = lowerQualityImage
                    }
                }
            }
        }
    }
}

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
