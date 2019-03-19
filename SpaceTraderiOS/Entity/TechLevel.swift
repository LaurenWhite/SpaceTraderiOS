//
//  TechLevel.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/27/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

public enum TechLevel: Int {
    case PRE_AGRICULTURE = 0
    case AGRICULTURE = 1
    case MEDIEVAL = 2
    case RENAISSANCE = 3
    case EARLY_INDUSTRIAL = 4
    case INDUSTRIAL = 5
    case POST_INDUSTRIAL = 6
    case HI_TECH = 7
}

public func enumToString(tl: TechLevel) -> String {
    var description = "\(tl)"
    description = description.replacingOccurrences(of: "_", with: " ")
    description = description.capitalized
    return description
}
