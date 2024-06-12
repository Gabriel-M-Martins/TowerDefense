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
    private let trueSize: CGSize
    private var pathToCity: CGPath = .init(rect: .zero, transform: .none)
    
    init() {
        let texture = Tokens.Textures.camp
        let originalSize = texture.size()
        let multiplier: CGFloat = 1
        let size: CGSize = .init(width: originalSize.width * multiplier, height: originalSize.height * multiplier)
        trueSize = size
        
        super.init(texture: texture, color: .clear, size: size)

        self.name = Names.camp.name
        
        self.zPosition = Layers.normal.layer
        
        Animations.spawn(on: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pathfind(to location: CGPoint, on graph: GKObstacleGraph<GKGraphNode2D>) -> Bool {
        guard let spawningPoint = findValidSpawningPoint() else { return false }
        
        let endNode = GKGraphNode2D(point: .init(x: Float(location.x), y: Float(location.y)))
        let startNode = GKGraphNode2D(point: .init(x: Float(spawningPoint.x), y: Float(spawningPoint.y)))
        
        graph.connectUsingObstacles(node: endNode)
        graph.connectUsingObstacles(node: startNode)
        
        
        let nodesFormingPath = graph.findPath(from: startNode, to: endNode) as! [GKGraphNode2D]
        if nodesFormingPath.contains(where:  { $0.position.x == Float.nan || $0.position.y == Float.nan }) { return false }
        
        for node in nodesFormingPath {
            let f = SKShapeNode(circleOfRadius: 10)
            f.fillColor = .brown
            f.position = .init(x: CGFloat(node.position.x), y: CGFloat(node.position.y))
            parent?.addChild(f)
        }
        
        guard let path = convertGraphNodesToPath(nodesFormingPath) else { return false }
        pathToCity = path
        graph.remove([startNode, endNode] + nodesFormingPath)
//        run(.sequence([
//            .follow(path, asOffset: false, orientToPath: false, speed: 500),
//            .removeFromParent()
//        ]))
        
        return true
    }
    
    private func findValidSpawningPoint() -> CGPoint? {
        var point: CGPoint
        var angle: Float = 0
        repeat {
            angle += 0.5
            point = Math.getPointOnCircle(radius: Float(trueSize.width) * 1.5, center: position, angle: Math.degreesToRadians(angle))
        } while (!(parent?.nodes(at: point).isEmpty ?? true)) && angle < 360
        
        if angle > 360 { return nil }
        
        let f = SKShapeNode(circleOfRadius: 15)
        f.fillColor = .red
        f.position = point
        f.zPosition = 30
        parent?.addChild(f)
        
        return point
    }
    
    private func convertGraphNodesToPath(_ nodes: [GKGraphNode2D]) -> CGPath? {
        guard nodes.count > 1 else { return nil }
        
        let path: CGMutablePath = .init()
        let first = nodes.first!
        
        path.move(to: .init(x: CGFloat(first.position.x), y: CGFloat(first.position.y)))
        for node in nodes.dropFirst() {
            path.addLine(to: CGPoint(x: CGFloat(node.position.x), y: CGFloat(node.position.y)))
        }
        
        let line = SKShapeNode(path: path)
        line.strokeColor = .green
        line.lineWidth = 3
        parent?.addChild(line)
        
        var intersections = [SKNode]()
        let terrain = (parent?.children.filter({ $0.name == Names.terrain.name }) ?? [])
        for i in 0..<nodes.count-1 {
            let current = nodes[i]
            let next = nodes[i + 1]
            
            for n in terrain {
                let intersects = Math.lineIntersectsRect(
                    lineStart: .init(x: CGFloat(current.position.x), y: CGFloat(current.position.y)),
                    lineEnd: .init(x: CGFloat(next.position.x), y: CGFloat(next.position.y)),
                    rect: n.frame)
                if intersects { intersections.append(n) }
            }
        }
        
        if !intersections.isEmpty {
            print(intersections.map({ "\($0)" }).joined(separator: "\n"))
            line.strokeColor = .cyan
        }
        
        
        return path
    }
}
