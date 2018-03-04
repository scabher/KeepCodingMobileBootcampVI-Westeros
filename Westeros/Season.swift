//
//  Season.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 27/2/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    init(name: String, releaseDate: Date, episodes: Episodes) {
        self.name = name
        self.releaseDate = releaseDate
        _episodes = episodes
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episode: Episode) {
        guard episode.season == self else {
            return
        }
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach{ add(episode: $0) }
    }
}

// MARK: - Proxy
extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate.description) \(count)"
    }
    
    var proxyForComparison: Double {
        return releaseDate.timeIntervalSince1970.magnitude
    }
}

//MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        return "\(name) \(releaseDate.description)"
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
