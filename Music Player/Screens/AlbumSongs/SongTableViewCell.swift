//
//  SongTableViewCell.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 21.07.2022.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songNumber: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songDuration: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func prepareForReuse() {
        super.prepareForReuse()
        songName.text = nil
        songDuration.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        containerView.backgroundColor = Constants.itemColor
        containerView.layer.cornerRadius = 10
        selectionStyle = .none
    }

    func setupCell(songName: String, songDuration: String? = nil, songNumber: Int) {
        self.songNumber.text = "\(songNumber)."
        self.songName.text = songName
        self.songDuration.text = songDuration
    }

    public static var nib: UINib {
        UINib(nibName: "SongTableViewCell", bundle: nil)
    }
    
}
