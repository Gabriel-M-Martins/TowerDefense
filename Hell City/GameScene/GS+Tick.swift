//
//  GS+Tick.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 05/06/24.
//

import Foundation
import Combine

extension GameScene {
    internal func setupTick() {
        let publisher = Timer
            .publish(every: 1, on: .main, in: .default)
            .autoconnect()
        
        let subscription = publisher
        subscription.sink { [weak self] _ in
            self?.tick()
        }
        .store(in: &cancellables)
    }
    
    fileprivate func tick() {
        settings.timer.time += 1
        let time = CGFloat(settings.timer.time)
        
        if gameState == .inGame {
            if time.remainder(dividingBy: settings.camp.timeBetweenSpawningNewCamp) == 0 {
                spawnCamp()
            }
        }
        
        // TODO: Spawn rates etc.
        for camp in self.camps {
            camp.spawn()
        }
    }
}
