//
//  TrafficAction.swift
//  Blind Transport
//
//  Created by Piotrek on 14/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public enum TraficIntensity: Int {
    case lowIntensity = 8
    case mediumIntensity = 4
    case heavyIntensity = 2
}

public class Traffic {
    
    public let road: Road
    public let intensity: TraficIntensity
    
    public var cars: [Vehicle] = []
    public var busses: [Bus] = []
    
    private var busOnRoad: Bool = false
    
    public init(on road: Road, with intensity: TraficIntensity) {
        self.road = road
        self.intensity = intensity
    }
    
    public func startTraffic() {
        cars.forEach { (vehicle) in vehicle.removeFromSuperview() }
        cars = []
        
        self.deployCar()
    }
    
    public func orderBus(for line: BusLine, in seconds: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {
            self.deployBus(for: line)
        }
    }
    
    private func deployCar() {
        let time: Int = .random(in: 0...intensity.rawValue)
        var line: Int = .random(in: 1...road.leftEndPoints.count) - 1
        let direction = VehicleDirection.allCases.randomElement()!
        
        if direction == .right && busOnRoad && line == (self.road.leftStratPoints.count - 1) { line = -1 }
        
        if line < 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
                self.deployCar()
            }
            return
        }
        
        let car = Vehicle(type: VehicleType.allCases.randomElement()!, direction: direction)
        car.startEngine()
        
        if direction == .left {
            car.center = road.rightStratPoints[line]
        } else {
            car.center = road.leftStratPoints[line]
        }
        
        cars.append(car)
        road.addSubview(car)
        
        UIView.animate(
            withDuration: 6.0 + Double(line * 4),
            delay: 0.0,
            options: .curveLinear,
            animations: {
                if direction == .left {
                    car.center = self.road.leftEndPoints[line]
                } else {
                    car.center = self.road.rightEndPoints[line]
                }
        }) { (_) in
            car.stopEngine()
            car.removeFromSuperview()
            self.cars.removeAll { (vehicle) -> Bool in vehicle == car }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
            self.deployCar()
        }
    }
    
    private func deployBus(for line: BusLine) {
        guard !busOnRoad else { return }
        busOnRoad = true
        
        let bus = Bus(line: line)
        bus.startEngine()
        bus.center = .init(
            x: road.leftStratPoints[self.road.leftStratPoints.count - 1].x - 65.0,
            y: road.leftStratPoints[self.road.leftStratPoints.count - 1].y
        )
        
        busses.append(bus)
        road.addSubview(bus)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseOut, animations: {
                bus.center = .init(x: self.road.center.x, y: bus.center.y)
            }) { (_) in
                bus.iddleEngine()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    bus.startEngine()
                    
                    UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseIn, animations: {
                        bus.center = .init(
                            x: self.road.rightEndPoints[self.road.rightEndPoints.count - 1].x + 65.0,
                            y: self.road.rightEndPoints[self.road.rightEndPoints.count - 1].y
                        )
                    }) { (_) in
                        bus.stopEngine()
                        bus.removeFromSuperview()
                        self.busses.removeAll { (vehicle) -> Bool in vehicle == bus }
                        self.busOnRoad = false
                    }
                }
            }
        }
    }
}
