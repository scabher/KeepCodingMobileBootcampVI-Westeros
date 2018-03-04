//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Sergio Cabrera Hernández on 27/2/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var episode1: Episode!
    var episode2: Episode!
    var season1: Season!
    
    override func setUp() {
        super.setUp()
        let seasons = Repository.local.seasons
        season1 = seasons[0]
        episode1 = season1.sortedEpisodes[0]
        episode2 = season1.sortedEpisodes[1]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1)
        XCTAssertNotNil(episode2)
    }
    
    func testEpisodeCustomString() {
        XCTAssertEqual(episode1.description, "Winter Is Coming Season 1")
    }
    
    func testEpisodeEquality() {
        // Identidad
        XCTAssertEqual(episode1, episode1)
        
        // Igualdad
        let ep1 = Episode(title: "Winter Is Coming", dateOfIssue: episode1.dateOfIssue, plot: episode1.plot, season: season1)
        XCTAssertEqual(ep1, episode1)
        
        // Desigualdad
        XCTAssertNotEqual(episode1, episode2)
    }
  
    func testEpisodeHashable() {
        XCTAssertNotNil(episode1.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(episode1, episode2)
    }
}
