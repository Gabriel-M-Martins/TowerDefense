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
    
    var obstacle: GKPolygonObstacle?
    
    init() {
        let texture = Tokens.Textures.Buildings.camp
        let originalSize = texture.size()
        let multiplier: CGFloat = 1
        let size: CGSize = .init(width: originalSize.width * multiplier, height: originalSize.height * multiplier)
        trueSize = size
        
        super.init(texture: texture, color: .clear, size: size)

        self.name = Names.camp.name
        
        self.zPosition = Layers.normal.layer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func spawn() {
        guard isAllowedToSpawn else { return }
        
        let f = Enemy()
        f.position = spawningPoint
        f.follow(path: pathToCity)
        
        parent?.addChild(f)
    }
}
