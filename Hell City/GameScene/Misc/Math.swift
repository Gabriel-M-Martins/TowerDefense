//
//  Math.swift
//  Hell City
//
//  Created by Gabriel Medeiros Martins on 05/06/24.
//

import Foundation
import CoreGraphics

struct Math {
    static func getRandomPointOnCircle(radius: Float, center: CGPoint) -> CGPoint {
        let theta = Float(arc4random_uniform(UInt32.max)) / Float(UInt32.max-1) * Float.pi * 2.0
        
        return getPointOnCircle(radius: radius, center: center, angle: theta)
    }
    
    static func degreesToRadians(_ degrees: Float) -> Float {
        return degrees * Float.pi * 2.0
    }
    
    static func getPointOnCircle(radius: Float, center: CGPoint, angle: Float) -> CGPoint {
        let x = radius * cos(angle)
        let y = radius * sin(angle)

        return CGPointMake(
            CGFloat(x) + center.x,
            CGFloat(y) + center.y
        )
    }
}
