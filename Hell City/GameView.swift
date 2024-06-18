//
//  GameView.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject private var scene: GameScene = .init()
    
    var body: some View {
        GeometryReader { reader in
            SpriteView(scene: scene, debugOptions: [.showsFPS, .showsNodeCount, .showsPhysics])
                .onAppear {
                    scene.size = reader.size
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GameView()
}
