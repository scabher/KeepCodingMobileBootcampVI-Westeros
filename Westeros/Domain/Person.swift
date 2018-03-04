//
//  Character.swift
//  Westeros
//
//  Created by Sergio Cabrera on 08/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import Foundation

final class Person {
    let name: String
    let house: House
    private let _alias: String?
    
    var alias: String {
        return _alias ?? ""
    }
    
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        _alias = alias
        self.house = house
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name.rawValue)"
    }
}

// MARK: - Proxies
extension Person {
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name.rawValue)"
    }
    
    var proxyForComparison: String {
        return "\(fullName)"
    }
}

// MARK: - Hashable
extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Comparable
extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}



