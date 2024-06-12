//
//  GS+Input.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation

extension GameScene {
    internal func handlePlacingTap(at location: CGPoint, _ placing: InputState.Placing) {
        switch placing {
        case .city(let node):
            let success = placeCity(at: location, node)
            if success { inputState = .normal }
        case .tower:
            break
        }
    }
}
