//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Sergio Cabrera on 13/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!
    var localSeasons: [Season]!
    
    override func setUp() {
        super.setUp()
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocalRepositoryCreation() {
        let local = Repository.local
        XCTAssertNotNil(local)
    }
    
    // MARK: - House tests
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        // [2, 5, 6, 10, 18].sorted()
        // [2, 5, 6, 10, 18]
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnsHouseByCaseInsensitively() {
        let stark = Repository.local.house(named: "sTarK")
        XCTAssertEqual(stark?.name.rawValue, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryReturnsHouseByEnum() {
        let stark = Repository.local.house(named: HouseName.targaryen)
        XCTAssertEqual(stark?.name, HouseName.targaryen)
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        XCTAssertEqual(filtered.count, 1)
        
        let otherFilter = Repository.local.houses(filteredBy: { $0.words.contains("invierno")})
        XCTAssertEqual(otherFilter.count, 1)
    }
    
    
    // MARK: - Season tests
    func testLocalRepositorySeasonCreation() {
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
    }
    
    func testLocalRepositoryReturnsSeasonByCaseInsensitively() {
        let season1 = Repository.local.season(named: "sEaSon 1")
        XCTAssertEqual(season1?.name, "Season 1")
        
        let keepcoding = Repository.local.season(named: "StarWars")
        XCTAssertNil(keepcoding)
    }
    
    func testSeasonFiltering() {
        let filtered = Repository.local.seasons(filteredBy: { $0.count == 2 })
        XCTAssertEqual(filtered.count, 7)
        
        let otherFilter = Repository.local.seasons(filteredBy: { $0.name.contains("7")})
        XCTAssertEqual(otherFilter.count, 1)
    }

}



















