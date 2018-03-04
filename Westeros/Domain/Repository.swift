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

        let starkHouse = House(name: HouseName.stark, sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")! )
        let lannisterHouse = House(name: HouseName.lannister, sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: HouseName.targaryen, sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter{ $0.name.rawValue.uppercased() == name.uppercased() }.first
        //let house = houses.first{ $0.name.uppercased() == name.uppercased() }
        return house
    }
    
    func house(named nameEnum: HouseName) -> House? {
        let house = houses.filter{ $0.name == nameEnum }.first
        return house
    }
    
    func houses(filteredBy: HouseFilter) -> [House] {
        return Repository.local.houses.filter(filteredBy)
    }
}

extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        // Seasons creation here
        let season1 = Season(name: "Season 1", releaseDate: dateFormatter.date(from: "04/17/11")!, episodes: Episodes())
        let season2 = Season(name: "Season 2", releaseDate: dateFormatter.date(from: "04/01/12")!, episodes: Episodes())
        let season3 = Season(name: "Season 3", releaseDate: dateFormatter.date(from: "03/31/13")!, episodes: Episodes())
        let season4 = Season(name: "Season 4", releaseDate: dateFormatter.date(from: "04/06/14")!, episodes: Episodes())
        let season5 = Season(name: "Season 5", releaseDate: dateFormatter.date(from: "04/12/15")!, episodes: Episodes())
        let season6 = Season(name: "Season 6", releaseDate: dateFormatter.date(from: "04/24/16")!, episodes: Episodes())
        let season7 = Season(name: "Season 7", releaseDate: dateFormatter.date(from: "06/16/17")!, episodes: Episodes())
       
        // Episodes creation here
        let episode1_1 = Episode(title: "Winter Is Coming",
                                 dateOfIssue: dateFormatter.date(from: "04/17/11")!,
                                 plot: "A Night's Watch deserter is tracked down outside of Winterfell, prompting swift justice from Lord Eddard 'Ned' Stark, and raising concerns about the dangers in the lawless lands north of the Wall. Returning home, Ned learns from his wife Catelyn that his mentor, Jon Arryn, has died in the Westeros's capital of King's Landing, and that King Robert is on his way north to offer Ned the position as the King's Hand. Meanwhile, across the Narrow Sea in Pentos, Viserys Targaryen hatches a plan to win back the throne by forging an allegiance with the nomadic Dothraki warriors by giving its leader, Khal Drogo, his lovely sister Daenerys's hand in marriage. Robert arrives at Winterfell with his wife, Queen Cersei, and other members of the Lannister family: her twin brother Jaime, dwarf brother Tyrion, and Cersei's son and heir to the throne, 12-year-old Joffrey. Unable to refuse his old friend and king, Ned prepares to leave for King's Landing, as Jon Snow decides to travel north to Castle Black to join the Night's Watch, accompanied by a curious Tyrion. But a startling act of treachery directed at young Bran may end up postponing their respective departures.",
                                 season: season1)
        
        let episode1_2 = Episode(title: "The Kingsroad ",
                                 dateOfIssue: dateFormatter.date(from: "04/24/11")!,
                                 plot: "Bran's fate remains in doubt. Having agreed to become the King's Hand, Ned leaves the North with daughters Sansa and Arya, while Catelyn stays behind to tend to Bran. Jon Snow heads north to join the brotherhood of the Night's Watch. Tyrion decides to forgo the trip south with his family, instead joining Jon in the entourage heading to the Wall. Viserys bides his time in hopes of winning back the throne, while Dany focuses her attention on learning how to please her new husband, Drogo.",
                                 season: season1)
        
        let episode2_1 = Episode(title: "The North Remembers",
                                 dateOfIssue: dateFormatter.date(from: "04/01/12")!,
                                 plot: "As Robb Stark and his northern army continue the war against the Lannisters, Tyrion arrives in King's Landing to counsel Joffrey and temper the young king's excesses. On the island of Dragonstone, Stannis Baratheon plots an invasion to claim his late brother's throne, allying himself with the fiery Melisandre, a strange priestess of a stranger god. Across the sea, Daenerys, her three young dragons, and khalasar trek through the Red Waste in search of allies, or water. In the North, Bran presides over a threadbare Winterfell while, beyond the Wall, Jon Snow and the Night's Watch must shelter with a devious wildling.",
                                 season: season2)
        
        let episode2_2 = Episode(title: "The Night Lands",
                                 dateOfIssue: dateFormatter.date(from: "04/08/12")!,
                                 plot: "In the wake of a bloody purge in the capital, Tyrion chastens Cersei for alienating the king's subjects. On the road north, Arya shares a secret with a Night's Watch recruit named Gendry. With supplies dwindling, one of Dany's scouts returns with news of their position. After nine years as a Stark ward, Theon Greyjoy reunites with his father Balon and sister Yara, who want to restore the ancient Kingdom of the Iron Islands. Davos enlists Salladhor Saan, a pirate, to join forces with Stannis and Melisandre for a naval invasion of King's Landing.",
                                 season: season2)
        
        let episode3_1 = Episode(title: "Valar Dohaeris",
                                 dateOfIssue: dateFormatter.date(from: "03/31/13")!,
                                 plot: "Jon is brought before Mance Rayder, the King Beyond the Wall, while the Night's Watch survivors retreat south. In King's Landing, Tyrion asks for his reward, Littlefinger offers Sansa a way out, and Cersei hosts a dinner for the royal family. Dany sails into Slaver's Bay.",
                                 season: season3)
        
        let episode3_2 = Episode(title: "Dark Wings, Dark Words",
                                 dateOfIssue: dateFormatter.date(from: "04/07/13")!,
                                 plot: "Sansa says too much. Shae asks Tyrion for a favor. Jaime finds a way to pass the time. Arya runs into the Brotherhood Without Banners.",
                                 season: season3)
        
        let episode4_1 = Episode(title: "Two Swords",
                                 dateOfIssue: dateFormatter.date(from: "04/06/14")!,
                                 plot: "Tyrion welcomes a guest to King's Landing while at Castle Black, Jon Snow finds himself unwelcome. Dany is pointed to Meereen, the mother of all slave cities. Arya runs into an old friend.",
                                 season: season4)
        
        let episode4_2 = Episode(title: "The Lion and the Rose",
                                 dateOfIssue: dateFormatter.date(from: "04/13/14")!,
                                 plot: "Tyrion lends Jaime a hand. Joffrey and Margaery host a breakfast. At Dragonstone, Stannis loses patience with Davos. Ramsay finds a purpose for his pet. North of the Wall, Bran sees where they must go.",
                                 season: season4)
        
        let episode5_1 = Episode(title: "The Wars to Come",
                                 dateOfIssue: dateFormatter.date(from: "04/12/15")!,
                                 plot: "Cersei and Jaime adjust to a world without Tywin. Varys reveals a conspiracy to Tyrion. Dany faces a new threat to her rule. Jon is caught between two kings.",
                                 season: season5)
        
        let episode5_2 = Episode(title: "The House of Black and White",
                                 dateOfIssue: dateFormatter.date(from: "04/19/15")!,
                                 plot: "Arya arrives in Braavos. Pod and Brienne run into trouble on the road. Cersei fears for her daughter's safety in Dorne as Ellaria Sand seeks revenge for Oberyn's death. Stannis tempts Jon. An adviser tempts Dany.",
                                 season: season5)
        
        let episode6_1 = Episode(title: "The Red Woman",
                                 dateOfIssue: dateFormatter.date(from: "04/24/16")!,
                                 plot: "At Castle Black, Thorne defends his treason while Edd and Davos defend themselves. Sansa and Theon race the cold and the hounds.",
                                 season: season6)
        
        let episode6_2 = Episode(title: "Home",
                                 dateOfIssue: dateFormatter.date(from: "05/01/16")!,
                                 plot: "Bran trains with the Three-Eyed Raven. In King's Landing, Jaime advises Tommen. Tyrion demands good news, but has to make his own. At Castle Black, the Night's Watch stands behind Thorne. Ramsay Bolton proposes a plan, and Balon Greyjoy entertains other proposals.",
                                 season: season6)
        
        let episode7_1 = Episode(title: "Dragonstone",
                                 dateOfIssue: dateFormatter.date(from: "06/16/17")!,
                                 plot: "Jon Snow organizes the defense of the North. Cersei tries to even the odds. Samwell discovers crucial information. Daenerys comes home.",
                                 season: season7)
        
        let episode7_2 = Episode(title: "Stormborn",
                                 dateOfIssue: dateFormatter.date(from: "06/23/17")!,
                                 plot: "Daenerys receives an unexpected visitor. Jon faces a revolt. Sam risks his career and life. Tyrion plans the conquest of Westeros.",
                                 season: season7)

        
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








