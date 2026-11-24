//
//  PedestriansAction.swift
//  Blind Transport
//
//  Created by Piotrek on 15/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public enum PedestiansIntensity: Int {
    case lowIntensity = 20
    case mediumIntensity = 10
    case heavyIntensity = 5
}

public class Pedestians {
    
    public let sidewalk: Sidewalk
    public let intensity: PedestiansIntensity
    
    public var pedestians: [Person] = []
    
    public init(on sidewalk: Sidewalk, with intensity: PedestiansIntensity) {
        self.sidewalk = sidewalk
        self.intensity = intensity
    }
    
    public func startTraffic() {
        pedestians.forEach { (vehicle) in vehicle.removeFromSuperview() }
        pedestians = []
        
        self.deployPerson()
    }
    
    private func deployPerson() {
        let time: Int = .random(in: 0...intensity.rawValue)
        let direction = PersonDirection.allCases.randomElement()!
        
        let person = Person(type: PersonType.allCases.randomElement()!, direction: direction)
        
        if direction == .left {
            person.center = sidewalk.leftPoint
        } else {
            person.center = sidewalk.rightPoint
            person.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
        }
        
        pedestians.append(person)
        sidewalk.addSubview(person)
        
        person.walk()
        UIView.animate(
            withDuration: 18.0,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                if direction == .left {
                    person.center = self.sidewalk.rightPoint
                } else {
                    person.center = self.sidewalk.leftPoint
                }
        }) { (_) in
            person.iddle()
            person.removeFromSuperview()
            self.pedestians.removeAll { (pedestian) -> Bool in pedestian == person }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
            self.deployPerson()
        }
    }
}
