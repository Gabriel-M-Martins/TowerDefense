//
//  PhysicsMasks.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 13/06/24.
//

import Foundation

struct PhysicsMasks {
    static let empty: UInt32 =          0x1 << 0
    static let enemy: UInt32 =          0x1 << 1
    static let attackRange: UInt32 =    0x1 << 2
    static let city: UInt32 =           0x1 << 3
    static let terrain: UInt32 =        0x1 << 4
    static let camp: UInt32 =           0x1 << 5
}
