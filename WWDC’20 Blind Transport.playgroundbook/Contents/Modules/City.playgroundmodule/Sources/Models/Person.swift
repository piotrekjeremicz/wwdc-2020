//
//  Person.swift
//  Blind Transport
//
//  Created by Piotrek on 15/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public enum PersonType: CaseIterable {
    case greenPerson
    case orangePerson
    case pinkPerson
    case redPerson
}

public enum PersonDirection: CaseIterable {
    case left
    case right
}

public class Person: UIImageView {
    public let type: PersonType
    public let direction: PersonDirection
    
    public var size: CGSize {
        return CGSize(width: 24.0, height: 40.0)
    }
    
    public init(type: PersonType, direction: PersonDirection) {
        self.type = type
        self.direction = direction
        
        super.init(frame: .zero)
        frame.size = size
        contentMode = .scaleAspectFit
        
        switch self.type {
            case .greenPerson:
                animationImages = [
                    UIImage.init(named: "person_green_0")!,
                    UIImage.init(named: "person_green_1")!,
                    UIImage.init(named: "person_green_2")!
                ]
            case .orangePerson:
                animationImages = [
                    UIImage.init(named: "person_orange_0")!,
                    UIImage.init(named: "person_orange_1")!,
                    UIImage.init(named: "person_orange_2")!
                ]
            case .pinkPerson:
                animationImages = [
                    UIImage.init(named: "person_pink_0")!,
                    UIImage.init(named: "person_pink_1")!,
                    UIImage.init(named: "person_pink_2")!
                ]
            case .redPerson:
                animationImages = [
                    UIImage.init(named: "person_red_0")!,
                    UIImage.init(named: "person_red_1")!,
                    UIImage.init(named: "person_red_2")!
                ]
        }
        
        animationDuration = 1.0
        animationRepeatCount = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func walk() {
        startAnimating()
    }
    
    public func iddle() {
        stopAnimating()
    }
}
