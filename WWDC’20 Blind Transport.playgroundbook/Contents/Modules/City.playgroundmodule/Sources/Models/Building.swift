//
//  Building.swift
//  Blind Transport
//
//  Created by Piotrek on 17/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public enum BuildingType {
    case house
    case office
    case shoppingMall
}

public enum BuildingDirection {
    case top
    case bottom
}

public class Building: UIImageView {
    public let type: BuildingType
    public let direction: BuildingDirection
    
    public var size: CGSize {
        switch type {
            case .house:
                return .init(width: 504.0, height: 304.0)
            case .office:
                return .init(width: 700.0, height: 358.0)
            case .shoppingMall:
                return .init(width: 780.0, height: 325.0)
        }
    }
    
    public init(type: BuildingType, direction: BuildingDirection) {
        self.type = type
        self.direction = direction
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        frame.size = size
        
        switch self.type {
            case .house:
                image = UIImage.init(named: "house")
            case .office:
                image = UIImage.init(named: "office_1")
            case .shoppingMall:
                image = UIImage.init(named: "office_2")
        }
        
        if direction == .top {
            transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



