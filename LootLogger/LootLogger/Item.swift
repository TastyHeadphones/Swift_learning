//
//  Items.swift
//  LootLogger
//
//  Created by Magic Keegan on 10/6/21.
//

import UIKit

class Item : Equatable{
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.valueInDollars == rhs.valueInDollars
        && lhs.dateCreated == rhs.dateCreated
        && lhs.serialNumber == rhs.serialNumber
        && lhs.name == rhs.name
    }
    
    var name:String
    var valueInDollars:Int
    var serialNumber:String?
    let dateCreated:Date
    
    init(name:String,valueInDollars:Int,serialNumber:String?)
    {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int.random(in: 0..<100)
            let randomSerialNumber =
                UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName,
                      valueInDollars: randomValue,
                      serialNumber: randomSerialNumber)
            }
        
        else {
            self.init(name: "", valueInDollars: 0,serialNumber: nil)
        }
    }
}
