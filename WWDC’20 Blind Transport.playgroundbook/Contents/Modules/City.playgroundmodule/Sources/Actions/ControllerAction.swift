//
//  ControllerAction.swift
//  Blind Transport
//
//  Created by Piotrek on 15/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public enum ControllerDirection {
    case left
    case top
    case right
    case bottom
    case none
}

public class Controller {
    
    public var isEnabled = true
    
    public var beginPoint: CGPoint?
    public var direction: ControllerDirection = .none
    
    public var marker: UIView?
    
    public func touchStart(from point: CGPoint, in view: UIView) {
        guard isEnabled else { return }
        self.beginPoint = point
        
        marker = UIView(frame: .init(x: 0.0, y: 0.0, width: 160.0, height: 160.0))
        marker!.center = point
        marker!.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        marker!.layer.cornerRadius = 80.0
        
        let circle = UIView(frame: .init(x: 70.0, y: 70.0, width: 20.0, height: 20.0))
        circle.backgroundColor = UIColor.gray
        circle.layer.cornerRadius = 10.0
        
        marker?.addSubview(circle)
        view.addSubview(marker!)
    }
    
    public func touchMoved(to point: CGPoint) {
        guard let beginPoint = self.beginPoint else { return }
        
        let x = point.x - beginPoint.x
        let y = point.y - beginPoint.y
        let angle = abs(point.angle(to: beginPoint))
        
        if x == point.x && y == point.y {
            direction = .none
        } else if angle >= 270.0 - 45.0 && angle < 270.0 + 45.0 {
            direction = .bottom
        } else if angle >= 0.0 - 45.0 && angle < 0.0 + 45.0 {
            direction = .left
        } else if angle >= 180.0 - 45.0 && angle < 180.0 + 45.0 {
            direction = .right
        } else if angle >= 90.0 - 45.0 && angle < 90.0 + 45.0 {
            direction = .top
        }
    }
    
    public func touchEnded() {
        beginPoint = nil
        marker?.removeFromSuperview()
        marker = nil
    }
}

extension CGPoint {
    func angle(to comparisonPoint: CGPoint) -> CGFloat {
        let originX = comparisonPoint.x - self.x
        let originY = comparisonPoint.y - self.y
        let bearingRadians = atan2f(Float(originY), Float(originX))
        var bearingDegrees = CGFloat(bearingRadians).degrees
        while bearingDegrees < 0 {
            bearingDegrees += 360
        }
        return bearingDegrees
    }
}

extension CGFloat {
    var degrees: CGFloat {
        return self * CGFloat(180.0 / .pi)
    }
}
