//
//  Sidewalk.swift
//  Blind Transport
//
//  Created by Piotrek on 13/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public enum SidewalkPosition {
    case top
    case bottom
}

public enum SidewalkType {
    case gray
    case brown
}

public class Sidewalk: UIImageView {
    public let type: SidewalkType
    public let position: SidewalkPosition
    public let elements: SidewalkElements?
    public let accessory: SidewalkElement?
    
    public var pedestrians: Pedestians?
    
    public var height: CGFloat {
        return 120.0
    }
    
    public var leftPoint: CGPoint {
        switch position {
            case .top:
                return CGPoint(x: -30.0, y: 76.0)
            case .bottom:
            return CGPoint(x: -30.0, y: height - 76.0)
        }
    }
    
    public var rightPoint: CGPoint {
        switch position {
            case .top:
                return CGPoint(x: frame.width + 30, y: 76.0)
            case .bottom:
                return CGPoint(x: frame.width + 30, y: height - 76.0)
        }
    }
    
    public init(type: SidewalkType, position: SidewalkPosition, pedestrians intensity: PedestiansIntensity, elements: SidewalkElements?, accessory: SidewalkElement?) {
        self.type = type
        self.position = position
        self.elements = elements
        self.accessory = accessory
        
        if position == .top {
            self.elements?.centerElement.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
            self.elements?.leftElements.forEach({ (element) in
                element.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
            })
            self.elements?.rightElements.forEach({ (element) in
                element.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
            })
        }
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.pedestrians = Pedestians(on: self, with: intensity)
        
        switch self.type {
            case .gray:
                image = UIImage.init(named: "gray_sidewalk")
            case .brown:
                image = UIImage.init(named: "brown_sidewalk")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
