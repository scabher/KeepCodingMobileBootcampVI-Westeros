//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Sergio Cabrera Hernández on 27/2/18.
//  Copyright © 2018 Sergio Cabrera Hernández. All rights reserved.
//

import XCTest
@testable import Westeros  // Nuestra app. @testable = podemos acceder a todo lo que hay en la clase (incluso las privadas)

class SeasonTests: XCTestCase {
    
    var episode1_1: Episode!
    var episode1_2: Episode!
    var episode2_1: Episode!
    var season1: Season!
    var season2: Season!
    
    override func setUp() {
        super.setUp()
                
        season1 = Season(name: "Temporada 1", releaseDate: Date(), episodes: Episodes())
        season2 = Season(name: "Temporada 2", releaseDate: Date(), episodes: Episodes())
        
        episode1_1 = Episode(title: "Se acerca el invierno", dateOfIssue: Date(), season: season1)
        episode1_2 = Episode(title: "El Camino Real", dateOfIssue: Date(), season: season1)
        episode2_1 = Episode(title: "El Norte no olvida", dateOfIssue: Date(), season: season2)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSeasonExistence() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }
    
    func testAddEpisodes() {
        XCTAssertEqual(season1.count, 0)
        
        season1.add(episode: episode1_1)
        XCTAssertEqual(season1.count, 1)
        
        season1.add(episode: episode1_1)
        XCTAssertEqual(season1.count, 1)
        
        season1.add(episode: episode1_2)
        XCTAssertEqual(season1.count, 2)
        
        season1.add(episode: episode2_1)
        XCTAssertEqual(season1.count, 2)
        
        let episode1_3 = Episode(title: "Lord Nieve", dateOfIssue: Date(), season: season1)
        let episode1_4 = Episode(title: "Tullidos, bastardos y cosas rotas", dateOfIssue: Date(), season: season1)
        
        season2.add(episodes: episode2_1, episode2_1, episode1_1, episode1_2, episode1_3, episode1_4)
        XCTAssertEqual(season2.count, 1)
    }
    
    func testSeasonCustomString() {
        XCTAssertEqual(season1.description, "\(season1.name) \(season1.releaseDate.description)")
    }
    
    func testSeasonEquality() {
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let season1rep = Season(name: "Temporada 1", releaseDate: season1.releaseDate, episodes: Episodes())
        XCTAssertEqual(season1, season1rep)
        
        // Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }
    
    func testSeasonReturnsSortedArrayOfEpisodes() {
        season1.add(episode: episode1_2)
        season1.add(episode: episode1_1)
        
        XCTAssertEqual(season1.sortedEpisodes, [episode1_1, episode1_2])
    }
    
}
