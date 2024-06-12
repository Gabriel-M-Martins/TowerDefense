//
//  GS+Camera.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation
import SpriteKit

extension GameScene {
    internal func setupCamera(_ view: SKView) {
        let camera = SKCameraNode()
        addChild(camera)
        self.camera = camera
        camera.setScale((settings.camera.maxScale + settings.camera.minScale)/2.0)
    }
}
