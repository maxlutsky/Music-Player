//
//  PlayerViewController.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 21.07.2022.
//

import UIKit

class PlayerViewController: UIViewController {

    private let album: Album

    private var currentSong: Song {
        didSet {
            songName.text = currentSong.name
        }
    }

    private lazy var averageArtworkColor: UIColor = {
        album.artwork?.averageColor ?? .systemGray5
    }()

    private let albumArtwork: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        return stackView
    }()

    private let songName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let songAuthor: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

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
        let button = getControlButton(imageName: "play.fill",
                                      selector: #selector(playPauseButtonTapped))
        button.setImage(UIImage(systemName: "pause.fill"), for: .selected)
        return button
    }()

    private lazy var nextSong: UIButton = {
        let button = getControlButton(imageName: "forward.fill",
                                      selector: #selector(nextButtonTapped))
        return button
    }()

    private lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.tintColor = .white
        slider.value = 5
        return slider
    }()

    private lazy var cursor = Cursor<Song>(currentIndex: album.songs.firstIndex(where: { $0 == currentSong }) ?? 0,
                                           array: album.songs)


    init(album: Album, song: Song) {
        self.album = album
        self.currentSong = song
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = averageArtworkColor
        setupControlsStackView()
        setupViews()

        albumArtwork.image = album.artwork
        songName.text = currentSong.name
        songAuthor.text = album.author
    }

    func getControlButton(imageName: String, selector: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.contentScaleFactor = 0.5
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    @objc func previousButtonTapped() {
        if cursor.moveToPrevious() {
            currentSong = cursor.currentItem
        }
    }

    @objc func playPauseButtonTapped() {
        playPause.isSelected = !playPause.isSelected
    }

    @objc func nextButtonTapped() {
        if cursor.moveToNext() {
            currentSong = cursor.currentItem
        }
    }

    func setupViews() {
        view.addSubview(mainStackView)
        view.addSubview(albumArtwork)
        NSLayoutConstraint.activate([
            albumArtwork.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            albumArtwork.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            albumArtwork.rightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            albumArtwork.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumArtwork.widthAnchor.constraint(equalTo: albumArtwork.heightAnchor),

            mainStackView.topAnchor.constraint(equalTo: albumArtwork.bottomAnchor, constant: 30),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])

        mainStackView.addArrangedSubview(songName)
        mainStackView.setCustomSpacing(5, after: songName)
        mainStackView.addArrangedSubview(songAuthor)
        mainStackView.addArrangedSubview(controlsStackView)

        let volumeControlsStackView = UIStackView()
        volumeControlsStackView.axis = .horizontal
        volumeControlsStackView.distribution = .fill
        volumeControlsStackView.spacing = 8
        let minVolume = UIImageView(image: UIImage(systemName: "volume.fill"))
        minVolume.tintColor = .white
        minVolume.contentMode = .scaleAspectFit
        volumeControlsStackView.addArrangedSubview(minVolume)
        volumeControlsStackView.addArrangedSubview(volumeSlider)
        let maxVolume = UIImageView(image: UIImage(systemName: "volume.3.fill"))
        maxVolume.tintColor = .white
        maxVolume.contentMode = .scaleAspectFit
        volumeControlsStackView.addArrangedSubview(maxVolume)
        mainStackView.addArrangedSubview(volumeControlsStackView)
    }

    func setupControlsStackView() {
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
