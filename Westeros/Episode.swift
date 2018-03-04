//
//  Episode.swift
//  Westeros
//
//  Created by Sergio Cabrera Hernández on 27/2/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import Foundation

// MARK: - Episode
final class Episode {
    let title: String
    let dateOfIssue: Date
    let plot: String
    weak var season: Season!
    
    init(title: String, dateOfIssue: Date, plot: String, season: Season) {
        self.title = title
        self.dateOfIssue = dateOfIssue
        self.plot = plot
        self.season = season
    }
}

// MARK: - Proxy
extension Episode {
    var proxyForEquality: String {
        return "\(title) \(season.name) \(dateOfIssue.description)"
    }
    
    var proxyForComparison: Double {
        return dateOfIssue.timeIntervalSince1970.magnitude
    }
}

//MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    var description: String {
        return "\(title) \(season.name)"
    }
}

// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
