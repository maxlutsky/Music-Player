//
//  AlbumCollectionViewCell.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 21.07.2022.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albumArtworkView: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumAuthor: UILabel!
    @IBOutlet weak var titlesContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titlesContainerView.backgroundColor = Constants.itemColor
        titlesContainerView.layer.cornerRadius = Constants.cornerRadius
        albumArtworkView.layer.cornerRadius = Constants.cornerRadius
        albumTitle.font = Constants.headerFont

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        albumArtworkView.image = nil
        albumTitle.text = nil
        albumAuthor.text = nil
    }

    public func setupCell(albumTitle: String, albumAuthor: String, albumArtwork: UIImage? = nil) {
        self.albumTitle.text = albumTitle
        self.albumAuthor.text = albumAuthor
        self.albumArtworkView.image = albumArtwork
    }

    public static var nib: UINib {
        UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
    }
}
