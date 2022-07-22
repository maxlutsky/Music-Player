//
//  PlayerViewController.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 21.07.2022.
//

import UIKit

class PlayerViewController: UIViewController {

    private let kTintColor: UIColor = .white

    private let album: Album

    private var currentSong: Song {
        didSet {
            songName.text = currentSong.name
            songProgress.totalDuration = SongDurationFormatter.string(from: currentSong.duration)
            currentSongProgress = 0
        }
    }

    private var currentSongProgress: TimeInterval = 0 {
        didSet {
            songProgress.current = SongDurationFormatter.string(from: currentSongProgress)
            let progress = currentSongProgress/currentSong.duration
            songProgress.setProgress(Float(progress), animated: true)
        }
    }

    private let albumArtwork: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
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

    private lazy var songName: UILabel = {
        let label = UILabel()
        label.font = Constants.headerFont
        label.textColor = kTintColor
        return label
    }()

    private lazy var songAuthor: UILabel = {
        let label = UILabel()
        label.textColor = kTintColor
        return label
    }()

    private lazy var songProgress: SongProgress = {
        let songProgress = SongProgress()
        songProgress.tintColor = kTintColor
        return songProgress
    }()

    private lazy var playbackContorls: PlaybackControls = {
        let controls = PlaybackControls()
        controls.tintColor = kTintColor
        controls.delegate = self
        return controls
    }()

    private lazy var volumeSlider: VolumeSlider = {
        let slider = VolumeSlider()
        slider.tintColor = kTintColor
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
        setupBackground()
        setupViews()

        albumArtwork.image = album.artwork
        songName.text = currentSong.name
        songAuthor.text = album.author
        songProgress.totalDuration = SongDurationFormatter.string(from: currentSong.duration)
        songProgress.current = SongDurationFormatter.string(from: 0)

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    @objc func update() {
        if playbackContorls.isPause {
            return
        } else if currentSongProgress == currentSong.duration {
            nextTapped()
        } else {
            currentSongProgress += 1
        }
    }

    func setupBackground() {
        let backgroundImage = UIImageView(image: album.artwork?.blurred(5))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.darken()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        backgroundImage.clipToSuperview()
    }

    func setupViews() {
        view.addSubview(mainStackView)
        view.addSubview(albumArtwork)
        NSLayoutConstraint.activate([
            albumArtwork.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            albumArtwork.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor,
                                               constant: Constants.defaultSpacing),
            albumArtwork.rightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor,
                                                constant: -Constants.defaultSpacing),
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
        mainStackView.addArrangedSubview(songProgress)
        mainStackView.addArrangedSubview(playbackContorls)
        mainStackView.addArrangedSubview(volumeSlider)
    }
}

extension PlayerViewController: PlaybackControlsDelegate {
    func previousTapped() {
        if cursor.moveToPrevious() {
            currentSong = cursor.currentItem
        } else {
            playbackContorls.isPause = true
        }
    }

    func nextTapped() {
        if cursor.moveToNext() {
            currentSong = cursor.currentItem
        } else {
            playbackContorls.isPause = true
        }
    }
}
