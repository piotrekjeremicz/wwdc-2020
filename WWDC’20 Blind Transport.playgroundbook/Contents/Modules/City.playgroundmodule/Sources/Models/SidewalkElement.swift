//
//  SidewalkElement.swift
//  Blind Transport
//
//  Created by Piotrek on 14/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public enum SidewalkElementType {
    case bench
    case busStopSign
    case busShelter
    case blindLine
    case empty
}

public class SidewalkElement: UIImageView {
    public let type: SidewalkElementType
    
    public var size: CGSize {
        switch type {
            case .bench, .busStopSign, .empty:
                return .init(width: 120.0, height: 120.0)
            case .busShelter:
                return .init(width: 240.0, height: 120.0)
            case .blindLine:
                return .init(width: 0.0, height: 10.0)
        }
    }
    
    public init(type: SidewalkElementType) {
        self.type = type
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        if self.type == .busStopSign || self.type == .busShelter { layer.zPosition = 100 }
        
        switch self.type {
            case .bench:
                image = UIImage.init(named: "branch")
            case .busStopSign:
                image = UIImage.init(named: "bus_stop_sign")
            case .empty:
                image = .none
            case .busShelter:
                image = UIImage.init(named: "bus_shelter")
            case .blindLine:
                image = UIImage.init(named: "blind_line")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


