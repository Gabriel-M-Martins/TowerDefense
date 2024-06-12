//
//  Terrain.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

class Terrain: SKSpriteNode {
    init() {
        let texture = [Tokens.Textures.boulder1, Tokens.Textures.boulder2, Tokens.Textures.boulder3, Tokens.Textures.tree].randomElement()!
        let originalSize = texture.size()
        let multiplier: CGFloat = 1
        let size: CGSize = .init(width: originalSize.width * multiplier, height: originalSize.height * multiplier)
        
        super.init(texture: texture, color: .clear, size: size)
        
        self.name = Names.terrain.name
        
        let pb = SKPhysicsBody(texture: texture, size: size)
        pb.isDynamic = false
        
        self.physicsBody = pb
        self.zPosition = Layers.normal.layer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
