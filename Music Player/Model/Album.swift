//
//  Album.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 20.07.2022.
//

import Foundation
import UIKit

struct Album {
    let title: String
    let songs: [Song]
    let author: String
    let artwork: UIImage?

    static func getMockAlbums() -> [Album] {
        [Album(title: "A Day At The Races",
               songs: Song.getMockSongs(),
               author: "Queen",
               artwork: UIImage(named: "ADayAtTheRaces")),
         Album(title: "Hot Space",
               songs: Song.getMockSongs(),
               author: "Queen",
               artwork: UIImage(named: "HotSpace")),
         Album(title: "Jazz",
               songs: Song.getMockSongs(),
               author: "Queen",
               artwork: UIImage(named: "Jazz")),
         Album(title: "Queen",
               songs: Song.getMockSongs(),
               author: "Queen",
               artwork: UIImage(named: "Queen")),
         Album(title: "Sheer Heart Attack",
               songs: Song.getMockSongs(),
               author: "Queen",
               artwork: UIImage(named: "SheerHeartAttack"))]
    }
}
