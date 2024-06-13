//
//  Enemy.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 12/06/24.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    private let scale: CGFloat
    
    init(_ scale: CGFloat = 1) {
        self.scale = scale
        
        let texture = Tokens.Textures.Characters.enemy
        let originalSize = texture.size()
        let size: CGSize = .init(width: originalSize.width * scale, height: originalSize.height * scale)
        
        super.init(texture: texture, color: .clear, size: size)
        
        let pb = SKPhysicsBody(rectangleOf: size)
        pb.isDynamic = true
        pb.categoryBitMask = 0
        pb.contactTestBitMask = 0
        pb.collisionBitMask = 0
        self.physicsBody = pb
        
        self.name = Names.enemy.name
        
        self.zPosition = Layers.normal.layer
        
        addShadow()
        addSword()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func follow(path: CGPath) {
        run(.sequence([
            .follow(path, asOffset: false, orientToPath: false, speed: 500),
            .removeFromParent()
        ]))
    }
    
    fileprivate func addShadow() {
        let texture = Tokens.Textures.Characters.shadow
        let originalSize = texture.size()
        let size: CGSize = .init(width: originalSize.width * scale, height: originalSize.height * scale)
        
        let shadow = SKSpriteNode(texture: texture, size: size)
        shadow.position = .init(x: -self.size.width * 0.022, y: -self.size.height/2 + size.height/4)
        shadow.zPosition = Layers.normal.layer - 0.1
        
        addChild(shadow)
    }
    
    fileprivate func addSword() {
        let texture = Tokens.Textures.Items.sword
        let originalSize = texture.size()
        let size: CGSize = .init(width: originalSize.width * scale, height: originalSize.height * scale)
        
        let sword = SKSpriteNode(texture: texture, size: size)
        sword.position = .init(x: self.size.width/2 - size.width * 0.3, y: self.size.height * 0.07)
        sword.zPosition = Layers.normal.layer + 0.1
        
        addChild(sword)
    }
}
