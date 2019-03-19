//
//  Resource.swift
//  SpaceTraderiOS
//
//  Created by Lauren White on 2/27/19.
//  Copyright © 2019 Lauren White. All rights reserved.
//

import Foundation

public enum Resource: CaseIterable {
    case NON_SPECIAL_RESOURCES
    case MINERAL_RICH
    case MINERAL_POOR
    case DESERT
    case LOTS_OF_WATER
    case RICH_SOIL
    case POOR_SOIL
    case RICH_FAUNA
    case LIFELESS
    case WEIRD_MUSHROOMS
    case LOTS_OF_HERBS
    case ARTISTIC
    case WARLIKE
}

public func enumToString(resource: Resource) -> String {
    var description = "\(resource)"
    description = description.replacingOccurrences(of: "_", with: " ")
    description = description.capitalized
    return description
}

