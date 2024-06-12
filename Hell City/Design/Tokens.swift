//
//  Tokens.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit
import UIKit

struct Tokens {}

extension Tokens {
    struct Colors {
        static let background = UIColor.init(named: "Background")!
    }
}

extension Tokens {
    struct Textures {
        static let boulder1 = SKTexture(imageNamed: "Boulder 1")
        static let boulder2 = SKTexture(imageNamed: "Boulder 2")
        static let boulder3 = SKTexture(imageNamed: "Boulder 3")
        
        static let tree = SKTexture(imageNamed: "Tree")
        
        static let tower = SKTexture(imageNamed: "Tower")
        static let house = SKTexture(imageNamed: "House")
        static let camp = SKTexture(imageNamed: "Camp")
    }
}
