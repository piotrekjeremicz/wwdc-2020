//
//  CollisionAction.swift
//  Blind Transport
//
//  Created by Piotrek on 17/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

class Collision {
    let currentView: UIView
    let update: () -> (blindPerson: BlindCharacter, traffic: Traffic, sidewalks: [Pedestians])
    let collisionDetected: (_ object: UIView) -> ()
    
    var blindPerson: BlindCharacter = BlindCharacter()
    var busses: [Bus] = []
    var people: [Person] = []
    var vehicles: [Vehicle] = []
    var elements: [SidewalkElement] = []
    
    init(with view: UIView, update: @escaping () -> (blindPerson: BlindCharacter, traffic: Traffic, sidewalks: [Pedestians]), whenCollisionDetected: @escaping (_ object: UIView) -> ()) {
        self.update = update
        self.currentView = view
        self.collisionDetected = whenCollisionDetected
    }
    
    func checkCollision(for player: MainCharacter) {
        let updateState = self.update()
        self.blindPerson = updateState.blindPerson
        self.busses = updateState.traffic.busses
        self.vehicles = updateState.traffic.cars
        self.people = updateState.sidewalks.first!.pedestians + updateState.sidewalks.last!.pedestians
        
        var elementsArray: [SidewalkElement] = []
        if let elements = updateState.sidewalks.first?.sidewalk.elements {
            elementsArray = [elements.centerElement] + elements.leftElements + elements.rightElements
        }
        
        if let elements = updateState.sidewalks.last?.sidewalk.elements {
            elementsArray = [elements.centerElement] + elements.leftElements + elements.rightElements
        }
        
        self.elements = elementsArray

        guard let playerObject = player.layer.presentation() else { return }
        let playerFrame = playerObject.frame
        self.busses.forEach { (bus) in
            if let object = bus.layer.presentation(), bus.convert(object.bounds, to: self.currentView).contains(playerFrame) {
                self.collisionDetected(bus)
            }
        }
        
        if let blindObject = self.blindPerson.layer.presentation(), self.blindPerson.convert(self.blindPerson.bounds, to: self.currentView).contains(playerFrame) {
            self.collisionDetected(self.blindPerson)
        }

        self.vehicles.forEach { (vehicle) in
            if let object = vehicle.layer.presentation(), vehicle.convert(object.bounds, to: self.currentView).contains(playerFrame) {
                print("vehicle collision")
            }
        }
        
        self.elements.forEach { (element) in
            if let object = element.layer.presentation(), element.convert(object.bounds, to: self.currentView).contains(playerFrame) {
                self.collisionDetected(element)
            }
        }
        
        self.people.forEach { (person) in
            if let object = person.layer.presentation(), person.convert(object.bounds, to: self.currentView).contains(playerFrame) {
                print("person collision")
            }
        }
    }
}
