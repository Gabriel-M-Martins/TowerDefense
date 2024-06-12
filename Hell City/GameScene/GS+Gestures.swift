//
//  GS+Gestures.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

extension GameScene {
    internal func setupGestures(_ view: SKView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.cancelsTouchesInView = false
        view.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(onPinch(_:)))
        pinch.cancelsTouchesInView = false
        view.addGestureRecognizer(pinch)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        view.isExclusiveTouch = false
    }
    
    @objc func onPan(_ sender: UIPanGestureRecognizer) {
        guard let camera else { return }
        
        if sender.state == .began {
            settings.camera.previousPosition = camera.position
        }
        
        let translation = sender.translation(in: self.view)
        let newPosition = CGPoint(
            x: settings.camera.previousPosition.x + translation.x * -1 * camera.xScale,
            y: settings.camera.previousPosition.y + translation.y * camera.xScale
        )
        
        camera.position = newPosition
    }
    
    @objc func onPinch(_ sender: UIPinchGestureRecognizer) {
        guard let camera = self.camera else { return }
        
        if sender.state == .began {
            settings.camera.previousScale = camera.xScale
        }
        
        let newScale = settings.camera.previousScale * 1 / sender.scale
        
        let hasHitUpperScaleBound = newScale >= settings.camera.maxScale && newScale > settings.camera.previousScale
        let hasHitLowerScaleBound = newScale <= settings.camera.minScale && newScale < settings.camera.previousScale
        
        if hasHitUpperScaleBound || hasHitLowerScaleBound {
            sender.state = .ended
            return
        }
        
        camera.setScale(newScale)
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        let location = convertPoint(fromView: sender.location(in: view))
        switch inputState {
        case .normal:
            break
        case .placing(let placing):
            handlePlacingTap(at: location, placing)
        }
    }
}
