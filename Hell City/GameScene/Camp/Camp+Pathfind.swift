//
//  Camp+Pathfind.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 12/06/24.
//

import Foundation
import GameplayKit

extension Camp {
    func pathfind(to location: CGPoint, on graph: GKObstacleGraph<GKGraphNode2D>) -> Bool {
        guard let spawningPoint = findValidSpawningPoint() else { return false }
        
        self.spawningPoint = spawningPoint
        self.goalPoint = location
        
        let endNode = GKGraphNode2D(point: .init(x: Float(location.x), y: Float(location.y)))
        let startNode = GKGraphNode2D(point: .init(x: Float(spawningPoint.x), y: Float(spawningPoint.y)))
        
        graph.connectUsingObstacles(node: startNode)
        graph.connectUsingObstacles(node: endNode)
        
        let nodesFormingPath = graph.findPath(from: startNode, to: endNode) as! [GKGraphNode2D]
        if nodesFormingPath.contains(where:  { $0.position.x.isNaN || $0.position.y.isNaN }) { return false }
        
        guard let path = convertGraphNodesToPath(nodesFormingPath) else { return false }
        pathToCity = path
        graph.remove([startNode, endNode] + nodesFormingPath)
        
        isAllowedToSpawn = true
        
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
        
        return path
    }
}
