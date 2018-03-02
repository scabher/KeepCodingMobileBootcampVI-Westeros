//
//  Repository.swift
//  Westeros
//
//  Created by Sergio Cabrera on 13/02/2018.
//  Copyright © 2018 Sergio Cabrera. All rights reserved.
//

import UIKit


final class Repository {
    static let local = LocalFactory()
}

// MARK: - Protocolos
protocol HouseFactory {
    
    typealias HouseFilter = (House) -> Bool
    
    var houses: [House] { get }
    func house(named: String) -> House?
    func houses(filteredBy: HouseFilter) -> [House]
    }

protocol SeasonFactory {
    
    typealias SeasonFilter = (Season) -> Bool
    
    var seasons: [Season] { get }
    func season(named: String) -> Season?
    func seasons(filteredBy: SeasonFilter) -> [Season]
}

// MARK: - Factorías
final class LocalFactory: HouseFactory {
    
    var houses: [House] {
        // Houses creation here
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "León rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragón Tricéfalo")

        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")! )
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        // Add characters to houses
        starkHouse.add(person: arya)
        starkHouse.add(person: robb)
        lannisterHouse.add(person: tyrion)
        lannisterHouse.add(person: cersei)
        lannisterHouse.add(person: jaime)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter{ $0.name.uppercased() == name.uppercased() }.first
        //let house = houses.first{ $0.name.uppercased() == name.uppercased() }
        return house
    }
    
    func houses(filteredBy: HouseFilter) -> [House] {
        return Repository.local.houses.filter(filteredBy)
    }
}

extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        // Seasons creation here
        let season1 = Season(name: "Season 1", releaseDate: Date(), episodes: Episodes())
        let season2 = Season(name: "Season 2", releaseDate: Date(), episodes: Episodes())
        let season3 = Season(name: "Season 3", releaseDate: Date(), episodes: Episodes())
        let season4 = Season(name: "Season 4", releaseDate: Date(), episodes: Episodes())
        let season5 = Season(name: "Season 5", releaseDate: Date(), episodes: Episodes())
        let season6 = Season(name: "Season 6", releaseDate: Date(), episodes: Episodes())
        let season7 = Season(name: "Season 7", releaseDate: Date(), episodes: Episodes())

        
        let episode1_1 = Episode(title: "Se acerca el invierno", dateOfIssue: Date(), season: season1)
        let episode1_2 = Episode(title: "El Camino Real", dateOfIssue: Date(), season: season1)
        
        let episode2_1 = Episode(title: "El Norte no olvida", dateOfIssue: Date(), season: season2)
        let episode2_2 = Episode(title: "Las tierras de la noche", dateOfIssue: Date(), season: season2)
        
        let episode3_1 = Episode(title: "Valar Dohaeris", dateOfIssue: Date(), season: season3)
        let episode3_2 = Episode(title: "Alas negras, palabras negras", dateOfIssue: Date(), season: season3)
        
        let episode4_1 = Episode(title: "Dos espadas", dateOfIssue: Date(), season: season4)
        let episode4_2 = Episode(title: "El león y la rosa", dateOfIssue: Date(), season: season4)
        
        let episode5_1 = Episode(title: "Las guerras venideras", dateOfIssue: Date(), season: season5)
        let episode5_2 = Episode(title: "La Casa de Negro y Blanco", dateOfIssue: Date(), season: season5)
        
        let episode6_1 = Episode(title: "La mujer roja", dateOfIssue: Date(), season: season6)
        let episode6_2 = Episode(title: "A casa", dateOfIssue: Date(), season: season6)
        
        let episode7_1 = Episode(title: "Rocadragón", dateOfIssue: Date(), season: season7)
        let episode7_2 = Episode(title: "Nacido de la tormenta", dateOfIssue: Date(), season: season7)

        
        // Add episodes to seasons
        season1.add(episodes: episode1_1, episode1_2)
        season2.add(episodes: episode2_1, episode2_2)
        season3.add(episodes: episode3_1, episode3_2)
        season4.add(episodes: episode4_1, episode4_2)
        season5.add(episodes: episode5_1, episode5_2)
        season6.add(episodes: episode6_1, episode6_2)
        season7.add(episodes: episode7_1, episode7_2)

        
        return [season1, season2, season3, season4, season5, season6, season7].sorted()
    }
    
    func season(named name: String) -> Season? {
        let season = seasons.filter{ $0.name.uppercased() == name.uppercased() }.first
        return season
    }
    
    func seasons(filteredBy: SeasonFilter) -> [Season] {
        return Repository.local.seasons.filter(filteredBy)
    }
}








