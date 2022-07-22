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

extension UIView {
    func darken(_ amount: CGFloat = 0.6) {
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(amount)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(darkView)
        darkView.clipToSuperview()
    }

    func clipToSuperview() {
        if let superView = self.superview {
            NSLayoutConstraint.activate([
                self.leftAnchor.constraint(equalTo: superView.leftAnchor),
                self.topAnchor.constraint(equalTo: superView.topAnchor),
                self.rightAnchor.constraint(equalTo: superView.rightAnchor),
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
            ])
        }
    }
}


