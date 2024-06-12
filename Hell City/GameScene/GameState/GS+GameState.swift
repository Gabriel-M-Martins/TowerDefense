//
//  GS+GameState.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

extension GameScene {
    internal func updateGameState() {
        switch gameState {
        case .started:
            transitionToGameStartedState()
        case .inGame:
            transitionToInGameState()
        default:
            break
        }
    }
    
    internal func transitionToGameStartedState() {
        createBottomText(.placeCity)
    }
    
    internal func transitionToInGameState() {
        removeUIElement(.placeCity)
    }
}
