//
//  GameScene.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import SpriteKit
import Combine
import GameplayKit

class GameScene: SKScene, ObservableObject {
    internal var settings: GameSettings = .init()
    
    internal var cancellables: [AnyCancellable] = []
    
    internal var inputState: InputState = .placing(.city(nil))
    internal var gameState: GameState = .loading {
        didSet {
            updateGameState()
        }
    }
    
    internal var uiElements: [String : SKNode] = [:]
    
    internal var city: City?
    
    internal var camps: Set<Camp> = []
    
    internal var nodes: Dictionary<NodeType, Set<SKNode>> = [
        .Terrain : [],
        .Camp : [],
        .City : [],
        .Tower : [],
        .Enemy : [],
    ]
    
    internal var pathfindingGraph: GKObstacleGraph = .init(obstacles: [], bufferRadius: 100)
    
    override func didMove(to view: SKView) {
        self.backgroundColor = Tokens.Colors.background
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)

        setupCamera(view)
        
        setupGestures(view)
        
        setupTick()

        spawnTerrain(view)
                
        gameState = .started
    }
}
