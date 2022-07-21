//
//  ViewController.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 20.07.2022.
//

import UIKit

class AlbumsViewController: UIViewController {

    private let kControllerTitle = "My Albums"
    private let kAlbumCellIdentifier = "AlbumCell"

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    var albums: [Album] = Album.getMockAlbums()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        title = kControllerTitle
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(collectionView)


        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumCollectionViewCell.nib, forCellWithReuseIdentifier: kAlbumCellIdentifier)
    }
}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing/2

        return CGSize(width:widthPerItem, height:widthPerItem * 1.35)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAlbumCellIdentifier, for: indexPath) as? AlbumCollectionViewCell,
              indexPath.row < albums.count else { return UICollectionViewCell() }
        let album = albums[indexPath.row]
        cell.setupCell(albumTitle: album.title, albumAuthor: album.author, albumArtwork: album.artwork)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < albums.count {
            let album = albums[indexPath.row]
            let vc = AlbumSongsViewController(album: album)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

