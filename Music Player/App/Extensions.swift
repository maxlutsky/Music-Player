//
//  Extensions.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 22.07.2022.
//

import UIKit

extension UIImage {
    func blurred(_ amount: CGFloat = 30.0) -> UIImage? {
        guard let ciImg = CIImage(image: self) else { return nil }
        let blur = CIFilter(name: "CIGaussianBlur")
        blur?.setValue(ciImg, forKey: kCIInputImageKey)
        blur?.setValue(amount, forKey: kCIInputRadiusKey)
        if let outputImg = blur?.outputImage {
            return UIImage(ciImage: outputImg)
        }
        return nil
    }
}

extension UIImageView {
    func darken(_ amount: CGFloat = 0.6) {
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(amount)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(darkView)
        NSLayoutConstraint.activate([
            darkView.leftAnchor.constraint(equalTo: self.leftAnchor),
            darkView.topAnchor.constraint(equalTo: self.topAnchor),
            darkView.rightAnchor.constraint(equalTo: self.rightAnchor),
            darkView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


