//
//  Cursor.swift
//  Music Player
//
//  Created by Maksym Lutskyi on 21.07.2022.
//

import Foundation

struct Cursor<T> {
    var currentIndex: Int
    var array: [T]

    var hasPrevious: Bool{
        currentIndex > 0
    }
    var hasNext: Bool{
        currentIndex < array.count - 1
    }
    var currentItem: T{
        array[currentIndex]
    }

    mutating func moveToNext() -> Bool{
        if hasNext {
            currentIndex += 1
            return true
        } else {
            return false
        }
    }

    mutating func moveToPrevious() -> Bool{
        if hasPrevious {
            currentIndex -= 1
            return true
        } else {
            return false
        }
    }
}
