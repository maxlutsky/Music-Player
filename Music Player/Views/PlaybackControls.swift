//
//  PlaybackControls.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 22.07.2022.
//

import UIKit

protocol PlaybackControlsDelegate {
    func previousTapped()
    func nextTapped()
}

class PlaybackControls: UIView {

    public var isPause: Bool {
        get {
            playPause.isSelected
        }
        set {
            playPause.isSelected = newValue
        }
    }

    override var tintColor: UIColor! {
        didSet {
            previousSong.tintColor = tintColor
            playPause.tintColor = tintColor
            nextSong.tintColor = tintColor
        }
    }

    var delegate: PlaybackControlsDelegate?

    private let controlsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 70
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var previousSong: UIButton = {
        let button = getControlButton(imageName: "backward.fill",
                                      selector: #selector(previousButtonTapped))
        return button
    }()

    private lazy var playPause: UIButton = {
        let button = getControlButton(imageName: "pause.fill",
                                      selector: #selector(playPauseButtonTapped))
        button.setImage(UIImage(systemName: "play.fill"), for: .selected)
        return button
    }()

    private lazy var nextSong: UIButton = {
        let button = getControlButton(imageName: "forward.fill",
                                      selector: #selector(nextButtonTapped))
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupControlsStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupControlsStackView()
    }

    @objc func previousButtonTapped() {
        delegate?.previousTapped()
    }

    @objc func playPauseButtonTapped() {
        playPause.isSelected = !playPause.isSelected
    }

    @objc func nextButtonTapped() {
        delegate?.nextTapped()
    }

    func getControlButton(imageName: String, selector: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.contentScaleFactor = 0.5
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    func setupControlsStackView() {
        addSubview(controlsStackView)

        NSLayoutConstraint.activate([
            controlsStackView.leftAnchor.constraint(equalTo: leftAnchor),
            controlsStackView.topAnchor.constraint(equalTo: topAnchor),
            controlsStackView.rightAnchor.constraint(equalTo: rightAnchor),
            controlsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        controlsStackView.addArrangedSubview(previousSong)
        controlsStackView.addArrangedSubview(playPause)
        controlsStackView.addArrangedSubview(nextSong)

        NSLayoutConstraint.activate([
            previousSong.widthAnchor.constraint(equalTo: previousSong.heightAnchor),
            playPause.widthAnchor.constraint(equalTo: playPause.heightAnchor),
            nextSong.widthAnchor.constraint(equalTo: nextSong.heightAnchor)
        ])
    }
}
