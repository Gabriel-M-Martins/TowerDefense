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
        let texture = [Tokens.Textures.Terrain.boulder1, Tokens.Textures.Terrain.boulder2, Tokens.Textures.Terrain.boulder3, Tokens.Textures.Terrain.tree].randomElement()!
        let originalSize = texture.size()
        let multiplier: CGFloat = 1
        let size: CGSize = .init(width: originalSize.width * multiplier, height: originalSize.height * multiplier)
        
        super.init(texture: texture, color: .clear, size: size)
        
        self.name = Names.terrain
        
        let pb = SKPhysicsBody(texture: texture, size: size)
        pb.isDynamic = false
        
        self.physicsBody = pb
        self.zPosition = Layers.normal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
