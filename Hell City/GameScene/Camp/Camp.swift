//
//  Camp.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit
import GameplayKit

class Camp: SKSpriteNode {
    internal let trueSize: CGSize
    internal var spawningPoint: CGPoint = .zero
    internal var isAllowedToSpawn: Bool = false
    
    internal var pathToCity: CGPath = .init(rect: .zero, transform: .none)
    internal var goalPoint: CGPoint = .zero
    
    internal weak var gsenemy: (any GSEnemy)?
    
    var obstacle: GKPolygonObstacle?
    
    init(settings: GameSettings.Camp) {
        let texture = Tokens.Textures.Buildings.camp
        let originalSize = texture.size()
        let multiplier: CGFloat = 1
        let size: CGSize = .init(width: originalSize.width * multiplier, height: originalSize.height * multiplier)
        trueSize = size
                
        super.init(texture: texture, color: .clear, size: size)

        let pb = SKPhysicsBody(rectangleOf: size)
        pb.categoryBitMask = PhysicsMasks.camp
        pb.collisionBitMask = PhysicsMasks.empty
        pb.contactTestBitMask = PhysicsMasks.empty
        pb.isDynamic = false
        
        self.physicsBody = pb

        self.name = Names.camp
        self.zPosition = Layers.normal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func spawn() {
        guard isAllowedToSpawn else { return }
        gsenemy?.spawnEnemy(from: self)
    }
}
