//
//  GameState.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation

enum InputState {
    case placing(Placing)
    case normal
    
    enum Placing {
        case city(City?)
        case tower
    }
}
