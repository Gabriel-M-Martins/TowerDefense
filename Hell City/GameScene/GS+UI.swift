//
//  GS+UI.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

extension GameScene {
    internal func createBottomText(_ label: Label, animated: Bool = true) {
        let labels = label.values
        createBottomText(labels.text, named: labels.key, animated: animated)
    }
    
    internal func createBottomText(_ text: String, named: String, animated: Bool = true) {
        guard let view, let camera else { return }
        
        let text = SKLabelNode(text: "Choose where to place your city.")
        text.position.y = -view.frame.height * 0.4
        text.zPosition = Layers.UI
        text.name = named
        
        uiElements.updateValue(text, forKey: named)
        
        camera.addChild(text)
        if animated {
            Animations.spawn(on: text)
        }
    }
    
    internal func removeUIElement(_ label: Label, animated: Bool = true) {
        let labels = label.values
        removeUIElement(labels.key, animated: animated)
    }
    
    internal func removeUIElement(_ named: String, animated: Bool = true) {
        guard let node = uiElements[named] else { return }
        
        if animated {
            Animations.despawn(on: node)
        } else {
            node.removeFromParent()
        }
        
        uiElements.removeValue(forKey: named)
    }
}
