//
//  GameSettings.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation

struct GameSettings {
    let terrain: Terrain = .init(quantity: 100, scaleRange: 1..<2)
    let map: Map = .init(scale: 15)
    var camera: Camera = .init(maxScale: 15, minScale: 1.5, previousPosition: .zero, previousScale: 0)
    var timer: Timer = .init()
    var camp: Camp = .init(maxCamps: 20, timeBetweenSpawningNewCamp: 2)
    var city: City = .init(health: 200, attackRange: 500)
    var enemy: Enemy = .init(health: 20, speed: 200, damage: 5, attackInterval: 5)
}

extension GameSettings {
    struct Terrain {
        let quantity: Int
        let scaleRange: Range<CGFloat>
    }
    
    struct Map {
        let scale: CGFloat
    }
    
    struct Camera {
        let maxScale: CGFloat
        let minScale: CGFloat
        var previousPosition: CGPoint
        var previousScale: CGFloat
    }
    
    struct Camp {
        let maxCamps: Int
        var timeBetweenSpawningNewCamp: CGFloat
    }
    
    struct Timer {
        var time: UInt = 0
    }
    
    struct City {
        var health: Float
        var attackRange: CGFloat
    }
    
    struct Enemy {
        var health: Float
        var speed: CGFloat
        var damage: Float
        var attackInterval: CGFloat
    }
}
