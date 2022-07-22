//
//  SongDurationFormatter.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 22.07.2022.
//

import Foundation

class SongDurationFormatter {
    private init() {}

    private static let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    public static func string(from timeInterval: TimeInterval) -> String? {
        formatter.string(from: timeInterval)
    }
}
