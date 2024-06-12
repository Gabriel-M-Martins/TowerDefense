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
        let texture = Tokens.Textures.house
        let originalSize = texture.size()
        let multiplier: CGFloat = 1
        let size: CGSize = .init(width: originalSize.width * multiplier, height: originalSize.height * multiplier)
        
        super.init(texture: texture, color: .clear, size: size)
        
        let pb = SKPhysicsBody(texture: texture, size: size)
        pb.isDynamic = false
        self.physicsBody = pb
        
        self.name = Names.city.name
        
        self.zPosition = Layers.normal.layer
        Animations.spawn(on: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func findValidSpawningPoint() -> CGPoint? {
        guard let parent else { return nil }
        
        var point: CGPoint
        repeat {
            point = Math.getRandomPointOnCircle(radius: Float(size.width) * 1.5, center: position)
        } while !parent.nodes(at: point).isEmpty
        
        return point
    }
}
