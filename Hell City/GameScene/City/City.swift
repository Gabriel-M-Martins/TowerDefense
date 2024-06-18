//
//  City.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

class City: SKSpriteNode {
    init() {
        let texture = Tokens.Textures.Buildings.house
        let originalSize = texture.size()
        let multiplier: CGFloat = 1
        let size: CGSize = .init(width: originalSize.width * multiplier, height: originalSize.height * multiplier)
        
        super.init(texture: texture, color: .clear, size: size)
        
        let pb = SKPhysicsBody(texture: texture, size: size)
        pb.isDynamic = false
        self.physicsBody = pb
        
        self.name = Names.city
        
        self.zPosition = Layers.normal
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
}
