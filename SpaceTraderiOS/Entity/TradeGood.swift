//
//  TradeGood.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 3/14/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

struct MarketItem {
    var good: TradeGood
    var quantity: Int
    var price: Int
}

protocol TradeGood {
    var name: String { get }
    var mtlp: Int { get } // parsecs per gallon
    var mtlu: Int { get }
    var ttp: Int { get }
    var basePrice: Int { get }
    var ipl: Int { get }
    var variance: Int { get }
}

class Water: TradeGood {
    static func == (lhs: Water, rhs: Water) -> Bool { return true }
    
    var name = "Water"
    var mtlp = 0
    var mtlu = 0
    var ttp = 2
    var basePrice = 30
    var ipl = 3
    var variance = 4
}

class Furs: TradeGood {
    var name = "Furs"
    var mtlp = 0
    var mtlu = 0
    var ttp = 0
    var basePrice = 250
    var ipl = 10
    var variance = 10
}

class Food: TradeGood {
    var name = "Food"
    var mtlp = 1
    var mtlu = 0
    var ttp = 1
    var basePrice = 100
    var ipl = 5
    var variance = 5
}

class Ore: TradeGood {
    var name = "Ore"
    var mtlp = 2
    var mtlu = 2
    var ttp = 3
    var basePrice = 350
    var ipl = 20
    var variance = 10
}

class Games: TradeGood {
    var name = "Games"
    var mtlp = 3
    var mtlu = 1
    var ttp = 6
    var basePrice = 250
    var ipl = -10
    var variance = 5
}

class Firearms: TradeGood {
    var name = "Firearms"
    var mtlp = 3
    var mtlu = 1
    var ttp = 5
    var basePrice = 1250
    var ipl = -75
    var variance = 100
}

class Medicine: TradeGood {
    var name = "Medicine"
    var mtlp = 4
    var mtlu = 1
    var ttp = 6
    var basePrice = 650
    var ipl = -20
    var variance = 10
}

class Machines: TradeGood {
    var name = "Machines"
    var mtlp = 4
    var mtlu = 3
    var ttp = 5
    var basePrice = 900
    var ipl = -30
    var variance = 5
}

class Narcotics: TradeGood {
    var name = "Narcotics"
    var mtlp = 5
    var mtlu = 0
    var ttp = 5
    var basePrice = 3500
    var ipl = -125
    var variance = 150
}

class Robots: TradeGood {
    var name = "Robots"
    var mtlp = 6
    var mtlu = 4
    var ttp = 7
    var basePrice = 5000
    var ipl = -150
    var variance = 100
}
