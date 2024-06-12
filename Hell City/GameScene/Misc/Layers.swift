//
//  Layers.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 04/06/24.
//

import Foundation

enum Layers {
    case normal
    case UI
    
    var layer: CGFloat {
        switch self {
        case .normal:
            return 0.0
        case .UI:
            return 10.0
        }
    }
}
