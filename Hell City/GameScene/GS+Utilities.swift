//
//  GS+Utilities.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 17/06/24.
//

import Foundation
import SpriteKit

extension GameScene {
    internal func CheckIfIsValidPosition(against types: [NodeType], at point: CGPoint) -> Bool {
        let nodes = types
            .compactMap({ self.nodes[$0] })
            .reduce(Set<SKNode>()) { partialResult, nodes in
                partialResult.union(nodes)
            }
        
        return nodes.first(where: { $0.contains(point) }) == nil
    }
}
