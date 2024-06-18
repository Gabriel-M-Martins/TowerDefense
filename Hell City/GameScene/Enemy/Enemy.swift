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
    private var settings: GameSettings.Enemy
    
    init(settings: GameSettings.Enemy, scale: CGFloat = 1) {
        self.settings = settings
        self.scale = scale
        
        let texture = Tokens.Textures.Characters.enemy
        let originalSize = texture.size()
        let size: CGSize = .init(width: originalSize.width * scale, height: originalSize.height * scale)
        
        super.init(texture: texture, color: .clear, size: size)
        
        let pb = SKPhysicsBody(rectangleOf: size)
        pb.isDynamic = true
        pb.categoryBitMask = PhysicsMasks.enemy
        pb.contactTestBitMask = 0
        pb.collisionBitMask = PhysicsMasks.enemy
        pb.allowsRotation = false
        
        self.physicsBody = pb
        
        self.name = Names.enemy
        self.zPosition = Layers.characters
        
        addShadow()
        addSword()
        
        Animations.spawn(on: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func follow(path: CGPath) {
        run(.sequence([
            .follow(path, asOffset: false, orientToPath: false, speed: settings.speed),
            .removeFromParent()
        ]))
    }
    
    func startAttacking(_ city: City) {
        run(
            .sequence([
                .run { [weak self] in
                    guard let self else { return }
                    let didKillCity = city.takeDamage(settings.damage, from: self)
                    if didKillCity {
                        self.removeAction(forKey: "Attack")
                    }
                },
                .wait(forDuration: settings.attackInterval)
            ]),
            withKey: "Attack"
        )
    }
    
    fileprivate func addShadow() {
        let texture = Tokens.Textures.Characters.shadow
        let originalSize = texture.size()
        let size: CGSize = .init(width: originalSize.width * scale, height: originalSize.height * scale)
        
        let shadow = SKSpriteNode(texture: texture, size: size)
        shadow.position = .init(x: -self.size.width * 0.022, y: -self.size.height/2 + size.height/4)
        shadow.zPosition = -self.zPosition
        
        addChild(shadow)
    }
    
    fileprivate func addSword() {
        let texture = Tokens.Textures.Items.sword
        let originalSize = texture.size()
        let size: CGSize = .init(width: originalSize.width * scale, height: originalSize.height * scale)
        
        let sword = SKSpriteNode(texture: texture, size: size)
        sword.position = .init(x: self.size.width/2 - size.width * 0.3, y: self.size.height * 0.07)
        sword.zPosition = 1.0
        
        addChild(sword)
    }
}
