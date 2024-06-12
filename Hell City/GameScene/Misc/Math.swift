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
    
    static func lineIntersectsRect(lineStart: CGPoint, lineEnd: CGPoint, rect: CGRect) -> Bool {
        let topLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let topRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.minY)
        
        return lineIntersectsLine(lineStart1: lineStart, lineEnd1: lineEnd, lineStart2: topLeft, lineEnd2: topRight) ||
               lineIntersectsLine(lineStart1: lineStart, lineEnd1: lineEnd, lineStart2: topRight, lineEnd2: bottomRight) ||
               lineIntersectsLine(lineStart1: lineStart, lineEnd1: lineEnd, lineStart2: bottomRight, lineEnd2: bottomLeft) ||
               lineIntersectsLine(lineStart1: lineStart, lineEnd1: lineEnd, lineStart2: bottomLeft, lineEnd2: topLeft)
    }

    static func lineIntersectsLine(lineStart1: CGPoint, lineEnd1: CGPoint, lineStart2: CGPoint, lineEnd2: CGPoint) -> Bool {
        let denominator = (lineEnd1.x - lineStart1.x) * (lineEnd2.y - lineStart2.y) - (lineEnd1.y - lineStart1.y) * (lineEnd2.x - lineStart2.x)
        if denominator == 0 {
            return false
        }
        
        let ua = ((lineStart2.x - lineStart1.x) * (lineEnd2.y - lineStart2.y) - (lineStart2.y - lineStart1.y) * (lineEnd2.x - lineStart2.x)) / denominator
        let ub = ((lineStart2.x - lineStart1.x) * (lineEnd1.y - lineStart1.y) - (lineStart2.y - lineStart1.y) * (lineEnd1.x - lineStart1.x)) / denominator
        
        return ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1
    }

}
