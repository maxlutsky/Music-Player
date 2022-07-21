//
//  VolumeSlider.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 21.07.2022.
//

import UIKit

class VolumeSlider: UIView {

    override var tintColor: UIColor! {
        didSet {
            volumeSlider.tintColor = tintColor
            minVolumeIcon.tintColor = tintColor
            maxVolumeIcon.tintColor = tintColor
        }
    }

    private var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 5
        return slider
    }()

    private lazy var minVolumeIcon: UIImageView = {
        getImageView(image: UIImage(systemName: "volume.fill"))
    }()

    private lazy var maxVolumeIcon: UIImageView = {
        getImageView(image: UIImage(systemName: "volume.3.fill"))
    }()

    func getImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        let volumeControlsStackView = UIStackView()
        volumeControlsStackView.axis = .horizontal
        volumeControlsStackView.distribution = .fill
        volumeControlsStackView.spacing = 8
        volumeControlsStackView.translatesAutoresizingMaskIntoConstraints = false

        volumeControlsStackView.addArrangedSubview(minVolumeIcon)
        volumeControlsStackView.addArrangedSubview(volumeSlider)
        volumeControlsStackView.addArrangedSubview(maxVolumeIcon)

        addSubview(volumeControlsStackView)
        NSLayoutConstraint.activate([
            volumeControlsStackView.leftAnchor.constraint(equalTo: leftAnchor),
            volumeControlsStackView.topAnchor.constraint(equalTo: topAnchor),
            volumeControlsStackView.rightAnchor.constraint(equalTo: rightAnchor),
            volumeControlsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
