//
//  World.swift
//  Blind Transport
//
//  Created by Piotrek on 15/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public class World {
    public let road: Road
    public let topSidewalk: Sidewalk
    public let bottomSidewalk: Sidewalk
    public let topEnvironment: [Building]
    public let bottomEnvironment: [Building]
    
    public init() {
        self.road = Road(type: .semiline, traffic: .lowIntensity)
        self.topSidewalk = Sidewalk(type: .gray, position: .top, pedestrians: .lowIntensity, elements: nil, accessory: nil)
        self.bottomSidewalk = Sidewalk(type: .gray, position: .bottom, pedestrians: .lowIntensity, elements: nil, accessory: nil)
        self.topEnvironment = []
        self.bottomEnvironment = []
    }
    
    public init(road: Road, withTop: Sidewalk, andBottom: Sidewalk, topEnvironment: [Building], bottomEnvironment: [Building]) {
        self.road = road
        self.topSidewalk = withTop
        self.bottomSidewalk = andBottom
        self.topEnvironment = topEnvironment
        self.bottomEnvironment = bottomEnvironment
    }
    
    public func run() {
        road.traffic?.startTraffic()
        topSidewalk.pedestrians?.startTraffic()
        bottomSidewalk.pedestrians?.startTraffic()
    }
    
    public func createConstraintArray(for view: UIView) -> [NSLayoutConstraint] {
        var constraints = [
            road.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            road.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0),
            road.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            road.heightAnchor.constraint(equalToConstant: road.height),
            
            topSidewalk.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            topSidewalk.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0),
            topSidewalk.bottomAnchor.constraint(equalTo: road.topAnchor, constant: 0.0),
            topSidewalk.heightAnchor.constraint(equalToConstant: topSidewalk.height),
            
            bottomSidewalk.topAnchor.constraint(equalTo: road.bottomAnchor, constant: 0.0),
            bottomSidewalk.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            bottomSidewalk.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0),
            bottomSidewalk.heightAnchor.constraint(equalToConstant: bottomSidewalk.height),
        ]
        
        if let elements = topSidewalk.elements {
            constraints += [
                elements.centerElement.centerXAnchor.constraint(equalTo: topSidewalk.centerXAnchor, constant: 0.0),
                elements.centerElement.topAnchor.constraint(equalTo: topSidewalk.topAnchor, constant: 0.0),
                elements.centerElement.bottomAnchor.constraint(equalTo: topSidewalk.bottomAnchor, constant: 0.0),
                elements.centerElement.widthAnchor.constraint(equalToConstant: elements.centerElement.size.width)
            ]
            
            var previousElement = elements.centerElement
            elements.rightElements.forEach { (element) in
                constraints += [
                    element.leftAnchor.constraint(equalTo: previousElement.rightAnchor, constant: 0.0),
                    element.topAnchor.constraint(equalTo: topSidewalk.topAnchor, constant: 0.0),
                    element.bottomAnchor.constraint(equalTo: topSidewalk.bottomAnchor, constant: 0.0),
                    element.widthAnchor.constraint(equalToConstant: previousElement.size.width),
                ]
                
                previousElement = element
            }
            
            previousElement = elements.centerElement
            elements.leftElements.forEach { (element) in
                constraints += [
                    element.rightAnchor.constraint(equalTo: previousElement.leftAnchor, constant: 0.0),
                    element.topAnchor.constraint(equalTo: topSidewalk.topAnchor, constant: 0.0),
                    element.bottomAnchor.constraint(equalTo: topSidewalk.bottomAnchor, constant: 0.0),
                    element.widthAnchor.constraint(equalToConstant: element.size.width),
                ]
                
                previousElement = element
            }
        }
        
        if let accessory = topSidewalk.accessory {
            constraints += [
                accessory.leftAnchor.constraint(equalTo: topSidewalk.leftAnchor, constant: 0.0),
                accessory.rightAnchor.constraint(equalTo: topSidewalk.rightAnchor, constant: 0.0),
                accessory.bottomAnchor.constraint(equalTo: topSidewalk.bottomAnchor, constant: 20.0),
                accessory.heightAnchor.constraint(equalToConstant: accessory.size.height)
            ]
        }
        
        if let elements = bottomSidewalk.elements {
            constraints += [
                elements.centerElement.centerXAnchor.constraint(equalTo: bottomSidewalk.centerXAnchor, constant: 0.0),
                elements.centerElement.topAnchor.constraint(equalTo: bottomSidewalk.topAnchor, constant: 0.0),
                elements.centerElement.bottomAnchor.constraint(equalTo: bottomSidewalk.bottomAnchor, constant: 0.0),
                elements.centerElement.widthAnchor.constraint(equalToConstant: elements.centerElement.size.width)
            ]
            
            var previousElement = elements.centerElement
            elements.rightElements.forEach { (element) in
                constraints += [
                    element.leftAnchor.constraint(equalTo: previousElement.rightAnchor, constant: 0.0),
                    element.topAnchor.constraint(equalTo: bottomSidewalk.topAnchor, constant: 0.0),
                    element.bottomAnchor.constraint(equalTo: bottomSidewalk.bottomAnchor, constant: 0.0),
                    element.widthAnchor.constraint(equalToConstant: element.size.width),
                ]
                
                previousElement = element
            }
            
            previousElement = elements.centerElement
            elements.leftElements.forEach { (element) in
                constraints += [
                    element.rightAnchor.constraint(equalTo: previousElement.leftAnchor, constant: 0.0),
                    element.topAnchor.constraint(equalTo: bottomSidewalk.topAnchor, constant: 0.0),
                    element.bottomAnchor.constraint(equalTo: bottomSidewalk.bottomAnchor, constant: 0.0),
                    element.widthAnchor.constraint(equalToConstant: element.size.width),
                ]
                
                previousElement = element
            }
        }
        
        if let accessory = bottomSidewalk.accessory {
            constraints += [
                accessory.leftAnchor.constraint(equalTo: bottomSidewalk.leftAnchor, constant: 0.0),
                accessory.rightAnchor.constraint(equalTo: bottomSidewalk.rightAnchor, constant: 0.0),
                accessory.topAnchor.constraint(equalTo: bottomSidewalk.topAnchor, constant: 20.0),
                accessory.heightAnchor.constraint(equalToConstant: accessory.size.height)
            ]
        }
        
        constraints += [
            topEnvironment[1].centerXAnchor.constraint(equalTo: topSidewalk.centerXAnchor, constant: 0.0),
            topEnvironment[1].bottomAnchor.constraint(equalTo: topSidewalk.topAnchor, constant: 0.0),
            topEnvironment[1].widthAnchor.constraint(equalToConstant: topEnvironment[1].size.width),
            topEnvironment[1].heightAnchor.constraint(equalToConstant: topEnvironment[1].size.height),
            
            topEnvironment[0].rightAnchor.constraint(equalTo: topEnvironment[1].leftAnchor, constant: 0.0),
            topEnvironment[0].bottomAnchor.constraint(equalTo: topSidewalk.topAnchor, constant: 0.0),
            topEnvironment[0].widthAnchor.constraint(equalToConstant: topEnvironment[0].size.width),
            topEnvironment[0].heightAnchor.constraint(equalToConstant: topEnvironment[0].size.height),
            
            topEnvironment[2].leftAnchor.constraint(equalTo: topEnvironment[1].rightAnchor, constant: 0.0),
            topEnvironment[2].bottomAnchor.constraint(equalTo: topSidewalk.topAnchor, constant: 0.0),
            topEnvironment[2].widthAnchor.constraint(equalToConstant: topEnvironment[2].size.width),
            topEnvironment[2].heightAnchor.constraint(equalToConstant: topEnvironment[2].size.height),
        ]
        
        constraints += [
            bottomEnvironment[1].centerXAnchor.constraint(equalTo: bottomSidewalk.centerXAnchor, constant: 0.0),
            bottomEnvironment[1].topAnchor.constraint(equalTo: bottomSidewalk.bottomAnchor, constant: 0.0),
            bottomEnvironment[1].widthAnchor.constraint(equalToConstant: bottomEnvironment[1].size.width),
            bottomEnvironment[1].heightAnchor.constraint(equalToConstant: bottomEnvironment[1].size.height),
            
            bottomEnvironment[0].rightAnchor.constraint(equalTo: bottomEnvironment[1].leftAnchor, constant: 0.0),
            bottomEnvironment[0].topAnchor.constraint(equalTo: bottomSidewalk.bottomAnchor, constant: 0.0),
            bottomEnvironment[0].widthAnchor.constraint(equalToConstant: bottomEnvironment[0].size.width),
            bottomEnvironment[0].heightAnchor.constraint(equalToConstant: bottomEnvironment[0].size.height),
            
            bottomEnvironment[2].leftAnchor.constraint(equalTo: bottomEnvironment[1].rightAnchor, constant: 0.0),
            bottomEnvironment[2].topAnchor.constraint(equalTo: bottomSidewalk.bottomAnchor, constant: 0.0),
            bottomEnvironment[2].widthAnchor.constraint(equalToConstant: bottomEnvironment[2].size.width),
            bottomEnvironment[2].heightAnchor.constraint(equalToConstant: bottomEnvironment[2].size.height),
        ]
        
        return constraints
    }
}

public class SidewalkElements {
    public let centerElement: SidewalkElement
    public let leftElements: [SidewalkElement]
    public let rightElements: [SidewalkElement]
    
    public init(center: SidewalkElement, left: [SidewalkElement], right: [SidewalkElement]) {
        self.centerElement = center
        self.leftElements = left
        self.rightElements = right
    }
}
