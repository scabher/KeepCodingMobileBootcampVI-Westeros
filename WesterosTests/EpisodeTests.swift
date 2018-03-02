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
                
        season1 = Season(name: "Temporada 1", releaseDate: Date(), episodes: Episodes())
        episode1 = Episode(title: "Se acerca el invierno", dateOfIssue: Date(), season: season1)
        episode2 = Episode(title: "El Camino Real", dateOfIssue: Date(), season: season1)
        season1.add(episode: episode1)
        season1.add(episode: episode2)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1)
        XCTAssertNotNil(episode2)
    }
    
    func testEpisodeCustomString() {
        XCTAssertEqual(episode1.description, "Se acerca el invierno Temporada 1")
    }
    
    func testEpisodeEquality() {
        // Identidad
        XCTAssertEqual(episode1, episode1)
        
        // Igualdad
        let ep1 = Episode(title: "Se acerca el invierno", dateOfIssue: episode1.dateOfIssue, season: season1)
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
