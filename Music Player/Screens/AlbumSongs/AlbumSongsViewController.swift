//
//  AlbumSongsViewController.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 21.07.2022.
//

import UIKit

class AlbumSongsViewController: UIViewController {

    private let kSongCellIdentifier = "SongCell"

    private let album: Album

    private lazy var songs: [Song] = album.songs

    private let albumArtwork: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        return imageView
    }()

    private let albumAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.separatorStyle = .none
        return tableView
    }()

    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        title = album.title
        navigationController?.navigationBar.prefersLargeTitles = true

        setupAlbumDetails()
        setupTableView()
        setupConstraints()
    }

    func setupAlbumDetails() {
        albumArtwork.image = album.artwork
        albumAuthor.text = album.author
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SongTableViewCell.nib, forCellReuseIdentifier: kSongCellIdentifier)
    }

    func setupConstraints() {
        view.addSubview(albumArtwork)
        NSLayoutConstraint.activate([
            albumArtwork.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                               constant: Constants.defaultSpacing),
            albumArtwork.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                              constant: Constants.defaultSpacing),
            albumArtwork.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            albumArtwork.heightAnchor.constraint(equalTo: albumArtwork.widthAnchor)
        ])

        view.addSubview(albumAuthor)
        NSLayoutConstraint.activate([
            albumAuthor.leftAnchor.constraint(equalTo: albumArtwork.rightAnchor,
                                              constant: Constants.defaultSpacing),
            albumAuthor.topAnchor.constraint(equalTo: albumArtwork.topAnchor),
            albumAuthor.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                               constant: -Constants.defaultSpacing),
            albumAuthor.bottomAnchor.constraint(lessThanOrEqualTo: albumArtwork.bottomAnchor,
                                                constant: -Constants.defaultSpacing)
        ])

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                            constant: Constants.defaultSpacing),
            tableView.topAnchor.constraint(equalTo: albumArtwork.bottomAnchor,
                                           constant: Constants.defaultSpacing),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                             constant: -Constants.defaultSpacing),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AlbumSongsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kSongCellIdentifier) as? SongTableViewCell,
              indexPath.row < songs.count else { return UITableViewCell() }
        let song = songs[indexPath.row]
        cell.setupCell(songName: song.name,
                       songDuration: SongDurationFormatter.string(from: song.duration),
                       songNumber: indexPath.row + 1)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < songs.count {
            let vc = PlayerViewController(album: album, song: songs[indexPath.row])
            self.present(vc, animated: true)
        }
    }
}
