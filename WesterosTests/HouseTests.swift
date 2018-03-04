//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Sergio Cabrera on 08/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    
    override func setUp() {
        super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "León rampante")
        
        starkHouse = House(name: HouseName.stark, sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        lannisterHouse = House(name: HouseName.lannister, sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
        XCTAssertNotNil(lannisterHouse)
    }
    
    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    func testAddPersons() {
     
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        
        lannisterHouse.add(persons: cersei, jaime, jaime, jaime, jaime, arya, robb)
        XCTAssertEqual(lannisterHouse.count, 3)
    }
    
    func testHouseEquality() {
        // Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // Igualdad
        let jinxed = House(name: HouseName.stark,
                           sigil: starkSigil,
                           words: "Se acerca el invierno",
                           url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        _ = Person(name: "Robb", alias: "El Joven Lobo", house: jinxed)
        _ = Person(name: "Arya", house: jinxed)
        
        XCTAssertEqual(jinxed, starkHouse)
        
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testHouseReturnsSortedArrayOfMembers() {
        starkHouse.add(person: robb)
        starkHouse.add(person: arya)
        
        XCTAssertEqual(starkHouse.sortedMembers, [arya, robb])
    }
}





































