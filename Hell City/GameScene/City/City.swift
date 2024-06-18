//
//  City.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

class City: SKSpriteNode {
    var settings: GameSettings.City
    var attackers: Set<SKNode> = [] {
        didSet {
            if !isDead || !attackers.isEmpty { return }
            // TODO: Kill city
        }
    }
    
    internal var isDead: Bool { settings.health <= 0 }
    
    init(settings: GameSettings.City) {
        let texture = Tokens.Textures.Buildings.house
        let originalSize = texture.size()
        let multiplier: CGFloat = 1
        let size: CGSize = .init(width: originalSize.width * multiplier, height: originalSize.height * multiplier)
        
        self.settings = settings
        
        super.init(texture: texture, color: .clear, size: size)
        
        let pb = SKPhysicsBody(texture: texture, size: size)
        pb.isDynamic = false
        pb.categoryBitMask = PhysicsMasks.city
        pb.collisionBitMask = PhysicsMasks.empty
        pb.contactTestBitMask = PhysicsMasks.enemy + PhysicsMasks.attackRange
        
        self.physicsBody = pb
        
        self.name = Names.city
        
        self.zPosition = Layers.normal
        
        addRange()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func findValidSpawningPoint() -> CGPoint? {
        guard let scene = parent as? GameScene else { return nil }
        
        for _ in 0..<50 {
            let point = Math.getRandomPointOnCircle(radius: Float(size.width) * 1.1, center: position)
            if scene.CheckIfIsValidPosition(against: [.Terrain], at: point) { return point }
        }
        
        return nil
    }
    
    func takeDamage(_ damage: Float, from origin: SKNode) -> Bool {
        if isDead {
            attackers.remove(origin)
            return true
        }
        
        settings.health -= damage
        attackers.insert(origin)

        return isDead
    }
    
    private func addRange() {
        let range = SKShapeNode(circleOfRadius: settings.attackRange)
        range.position = .zero
        
        let pb = SKPhysicsBody(circleOfRadius: settings.attackRange)
        pb.categoryBitMask = PhysicsMasks.attackRange
        pb.collisionBitMask = PhysicsMasks.empty
        pb.contactTestBitMask = PhysicsMasks.enemy
        
        range.physicsBody = pb
        
        addChild(range)
    }
}
