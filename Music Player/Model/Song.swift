//
//  Song.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 20.07.2022.
//

import Foundation

struct Song: Equatable {
    let name: String
    let duration: TimeInterval

    static func getMockSongs() -> [Song] {
        [Song(name: "Somebody to Love", duration: 300),
         Song(name: "Bicycle Race", duration: 180),
         Song(name: "Keep Yourself Alive", duration: 230),
         Song(name: "Killer Queen", duration: 180),
         Song(name: "Cool Cat", duration: 210)]
    }
}


