//
//  Road.swift
//  Blind Transport
//
//  Created by Piotrek on 13/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit
import Foundation

public enum RoadType {
    case semiline
    case doubleline
}

public class Road: UIImageView {
    public let type: RoadType
    public var traffic: Traffic?
    
    public var height: CGFloat {
        switch type {
        case .semiline:
            return 240.0
        case .doubleline:
            return 480.0
        }
    }
    
    public var leftStratPoints: [CGPoint] {
        switch type {
            case .semiline:
                return [
                    CGPoint(x: -100.0, y: frame.height - height/4)
                ]
            case .doubleline:
                return [
                    CGPoint(x: -100.0, y: frame.height - 3 * height/8),
                    CGPoint(x: -100.0, y: frame.height - height/8),
                ]
        }
    }
    
    public var leftEndPoints: [CGPoint] {
        switch type {
            case .semiline:
                return [
                    CGPoint(x: -100.0, y: height/4)
            ]
            case .doubleline:
                return [
                    CGPoint(x: -100.0, y: 3 * height/8),
                    CGPoint(x: -100.0, y: height/8),
            ]
        }
    }
    
    public var rightStratPoints: [CGPoint] {
        switch type {
            case .semiline:
                return [
                    CGPoint(x: frame.width + 100.0, y: height/4)
                ]
            case .doubleline:
                return [
                    CGPoint(x: frame.width + 100.0, y: 3 * height/8),
                    CGPoint(x: frame.width + 100.0, y: height/8),
                ]
        }
    }
    
    public var rightEndPoints: [CGPoint] {
        switch type {
            case .semiline:
                return [
                    CGPoint(x: frame.width + 100.0, y: frame.height - height/4)
            ]
            case .doubleline:
                return [
                    
                    CGPoint(x: frame.width + 100.0, y: frame.height - 3 * height/8),CGPoint(x: frame.width + 100.0, y: frame.height - height/8),
            ]
        }
    }
    
    public init(type: RoadType, traffic intensity: TraficIntensity) {
        self.type = type
        super.init(frame: .zero)
        
        self.traffic = Traffic(on: self, with: intensity)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        switch self.type {
        case .semiline:
            image = UIImage.init(named: "semiline_road")
        case .doubleline:
            image = UIImage.init(named: "doubleline_road")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
