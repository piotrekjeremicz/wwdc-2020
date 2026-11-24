//
//  PlaygroundBookHelper.swift
//  Blind Transport
//
//  Created by Piotrek on 18/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit
import AVFoundation

private var stopIsRitched = false
private var checkedTimetable = false
private var blindManWasInformed = false
private var speechSynthesizer = AVSpeechSynthesizer()

extension CityViewController {
    public func createStaticPage1() {
        self.world = World(
            road: Road(type: .semiline, traffic: .lowIntensity),
            withTop: Sidewalk(
                type: .brown,
                position: .top,
                pedestrians: .mediumIntensity,
                elements: nil,
                accessory: nil
            ),
            andBottom: Sidewalk(
                type: .brown,
                position: .bottom,
                pedestrians: .lowIntensity,
                elements: SidewalkElements(
                    center: SidewalkElement(type: .bench),
                    left: [SidewalkElement(type: .busStopSign)],
                    right: []
                ),
                accessory: nil
            ),
            topEnvironment: [
                Building(type: .house, direction: .top),
                Building(type: .house, direction: .top),
                Building(type: .house, direction: .top),
            ],
            bottomEnvironment: [
                Building(type: .house, direction: .bottom),
                Building(type: .house, direction: .bottom),
                Building(type: .house, direction: .bottom),
            ]
        )
        
        create(world: self.world)
    }
    
    public func createStaticPage2() {
        self.world = World(
            road: Road(type: .doubleline, traffic: .heavyIntensity),
            withTop: Sidewalk(
                type: .gray,
                position: .top,
                pedestrians: .heavyIntensity,
                elements: SidewalkElements(
                    center: SidewalkElement(type: .empty),
                    left: [SidewalkElement(type: .bench), SidewalkElement(type: .empty), SidewalkElement(type: .bench)],
                    right: [SidewalkElement(type: .bench), SidewalkElement(type: .empty), SidewalkElement(type: .bench)]
                ),
                accessory: nil
            ),
            andBottom: Sidewalk(
                type: .gray,
                position: .bottom,
                pedestrians: .mediumIntensity,
                elements: SidewalkElements(
                    center: SidewalkElement(type: .busShelter),
                    left: [],
                    right: [SidewalkElement(type: .busStopSign)]
                ),
                accessory: nil
            ),
            topEnvironment: [
                Building(type: .shoppingMall, direction: .top),
                Building(type: .shoppingMall, direction: .top),
                Building(type: .office, direction: .top),
            ],
            bottomEnvironment: [
                Building(type: .shoppingMall, direction: .bottom),
                Building(type: .office, direction: .bottom),
                Building(type: .shoppingMall, direction: .bottom),
            ]
        )
        
        create(world: self.world)
    }
    
    public func createStaticPage3() {
        self.world = World(
            road: Road(type: .doubleline, traffic: .lowIntensity),
            withTop: Sidewalk(
                type: .gray,
                position: .top,
                pedestrians: .lowIntensity,
                elements: SidewalkElements(
                    center: SidewalkElement(type: .empty),
                    left: [SidewalkElement(type: .bench), SidewalkElement(type: .empty), SidewalkElement(type: .bench)],
                    right: [SidewalkElement(type: .bench), SidewalkElement(type: .empty), SidewalkElement(type: .bench)]
                ),
                accessory: nil
            ),
            andBottom: Sidewalk(
                type: .gray,
                position: .bottom,
                pedestrians: .lowIntensity,
                elements: SidewalkElements(
                    center: SidewalkElement(type: .busShelter),
                    left: [],
                    right: [SidewalkElement(type: .busStopSign)]
                ),
                accessory: nil
            ),
            topEnvironment: [
                Building(type: .shoppingMall, direction: .top),
                Building(type: .shoppingMall, direction: .top),
                Building(type: .office, direction: .top),
            ],
            bottomEnvironment: [
                Building(type: .shoppingMall, direction: .bottom),
                Building(type: .office, direction: .bottom),
                Building(type: .shoppingMall, direction: .bottom),
            ]
        )
        
        create(world: self.world)
    }
    
    public func createStaticPage4() {
        self.world = World(
            road: Road(type: .semiline, traffic: .lowIntensity),
            withTop: Sidewalk(
                type: .brown,
                position: .top,
                pedestrians: .lowIntensity,
                elements: nil,
                accessory: nil
            ),
            andBottom: Sidewalk(
                type: .brown,
                position: .bottom,
                pedestrians: .lowIntensity,
                elements: SidewalkElements(
                    center: SidewalkElement(type: .bench),
                    left: [SidewalkElement(type: .busStopSign)],
                    right: []
                ),
                accessory: nil
            ),
            topEnvironment: [
                Building(type: .house, direction: .top),
                Building(type: .house, direction: .top),
                Building(type: .house, direction: .top),
            ],
            bottomEnvironment: [
                Building(type: .house, direction: .bottom),
                Building(type: .house, direction: .bottom),
                Building(type: .house, direction: .bottom),
            ]
        )
        
        create(world: self.world)
    }
    
    public func startPage1() {
        self.createStaticPage1()
        self.world.run()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let building = self.world.bottomEnvironment[0]
            let startPoint = CGPoint(
                x: building.frame.origin.x + building.size.width * 0.86,
                y: building.frame.origin.y + building.size.height * 0.58
            )
            
            self.character.center = startPoint
            self.view.addSubview(self.character)
            self.character.showMind(string: "⏰‼️")
            
            self.collision = Collision(
                with: self.view,
                update: { () -> (blindPerson: BlindCharacter, traffic: Traffic, sidewalks: [Pedestians]) in
                    return (blindPerson: self.blindCharacter, traffic: self.world.road.traffic!, sidewalks: [self.world.topSidewalk.pedestrians!, self.world.bottomSidewalk.pedestrians!])
            },
                whenCollisionDetected: { (object: UIView) in
                    switch object {
                        case is SidewalkElement:
                            if let element = object as? SidewalkElement, element.type == .busStopSign, self.hintImageView == nil {
                                self.presentCircleHint(.timetable1)
                                self.world.road.traffic?.orderBus(for: .orange, in: 5)
                        }
                        
                        case is Bus:
                            UIView.animate(withDuration: 0.5, animations: {
                                self.character.alpha = 0.0
                            }) { (_) in
                                self.presentCircleHint(.end1)
                        }
                        default:
                            break
                    }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.checkCollision()
            }
        }
    }
    
    public func startPage2() {
        self.createStaticPage2()
        self.world.run()
        
        self.controller.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.world.road.traffic?.orderBus(for: .orange, in: 2)
            
            let startPoint = CGPoint(
                x: -20.0,
                y: self.world.bottomSidewalk.center.y - 28.0
            )
            
            self.blindCharacter.center = startPoint
            self.view.addSubview(self.blindCharacter)
            
            self.blindCharacter.startAnimating()
            UIView.animate(withDuration: 16.0, delay: 4.0, options: .curveEaseInOut, animations: {
                self.blindCharacter.center.x = self.view.center.x
            }) { (_) in
                self.blindCharacter.transform = CGAffineTransform(rotationAngle: (270.0 * .pi) / 180.0)
                self.blindCharacter.stopAnimating()
                self.blindCharacter.showMind(string: "😕❓")
            }
            
            self.character.center = startPoint
            self.view.addSubview(self.character)
            
            self.character.startAnimating()
            UIView.animate(withDuration: 4.0, delay: 10.0, options: .curveEaseOut, animations: {
                self.character.center.x += 200.0
            }) { (_) in
                self.controller.isEnabled = true
                self.character.stopAnimating()
                self.character.showMind(string: "😓")
               
                self.presentCircleHint(.late)
            }
            
            self.collision = Collision(
                with: self.view,
                update: { () -> (blindPerson: BlindCharacter, traffic: Traffic, sidewalks: [Pedestians]) in
                    return (blindPerson: self.blindCharacter, traffic: self.world.road.traffic!, sidewalks: [self.world.topSidewalk.pedestrians!, self.world.bottomSidewalk.pedestrians!])
            },
                whenCollisionDetected: { (object: UIView) in
                    switch object {
                        case is SidewalkElement:
                            if let element = object as? SidewalkElement, element.type == .busStopSign, self.hintImageView == nil {
                                checkedTimetable = true
                                self.presentCircleHint(.timetable2)
                                self.character.showMind(string: "🤔")
                            }
                        
                            if let element = object as? SidewalkElement, element.type == .busShelter && checkedTimetable && !blindManWasInformed {
                                
                                blindManWasInformed = true
                                self.presentCircleHint(.blueLineIsArrive)
                                self.character.showMind(string: "🔹")
                                self.world.road.traffic?.orderBus(for: .blue, in: 4)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 11.0) {
                                    self.blindCharacter.startAnimating()
                                    UIView.animate(withDuration: 2.0, animations: {
                                        self.blindCharacter.center.y -= 20.0
                                    }) { (_) in
                                        UIView.animate(withDuration: 1.0, animations: {
                                            self.blindCharacter.alpha = 0.0
                                        }) { (_) in
                                            self.presentCircleHint(.orangeLineIsArrive)
                                            self.world.road.traffic?.orderBus(for: .orange, in: 5)
                                        }
                                    }
                                }
                            }
                        
                        case is Bus:
                            guard let bus = object as? Bus, bus.line == .orange else { return }
                            UIView.animate(withDuration: 0.5, animations: {
                                self.character.alpha = 0.0
                            }) { (_) in
                                self.presentCircleHint(.end2)
                        }
                        default:
                            break
                    }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.checkCollision()
            }
        }
    }
    
    public func startPage3() {
        createStaticPage3()
        world.run()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let startPoint = CGPoint(
                x: 180.0,
                y: self.world.bottomSidewalk.center.y - 28.0
            )
            
            self.character.center = startPoint
            self.view.addSubview(self.character)
            self.character.showMind(string: "‼️‼️‼️")
            
            self.world.road.traffic?.orderBus(for: .orange, in: 5)
            self.world.road.traffic?.orderBus(for: .blue, in: 10)
            self.world.road.traffic?.orderBus(for: .orange, in: 15)
            self.world.road.traffic?.orderBus(for: .blue, in: 20)
            self.world.road.traffic?.orderBus(for: .orange, in: 25)
            self.world.road.traffic?.orderBus(for: .blue, in: 30)
            
            
            self.collision = Collision(
                with: self.view,
                update: { () -> (blindPerson: BlindCharacter, traffic: Traffic, sidewalks: [Pedestians]) in
                    return (blindPerson: self.blindCharacter, traffic: self.world.road.traffic!, sidewalks: [self.world.topSidewalk.pedestrians!, self.world.bottomSidewalk.pedestrians!])
            },
                whenCollisionDetected: { (object: UIView) in
                    switch object {
                        case is SidewalkElement:
                            if let element = object as? SidewalkElement, element.type == .busShelter {
                                self.presentCircleHint(.busStop)
                        }
                        
                        case is Bus:
                            guard let bus = object as? Bus, bus.line == .blue else { return }
                            UIView.animate(withDuration: 0.5, animations: {
                                self.character.alpha = 0.0
                            }) { (_) in
                                self.presentCircleHint(.end3)
                        }
                        default:
                            break
                    }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.checkCollision()
            }
        }
    }
    
    public func startPage4() {
        self.createStaticPage4()
        world.run()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let startPoint = CGPoint(
                x: 20.0,
                y: self.world.bottomSidewalk.center.y - 28.0
            )
            
            self.character.center = startPoint
            self.view.addSubview(self.character)
            
            let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "You have one stop around. Go right.")
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            speechSynthesizer.speak(speechUtterance)
            
            self.world.road.traffic?.orderBus(for: .orange, in: 20)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "The orange bus line is arriving.")
                speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                speechSynthesizer.stopSpeaking(at: .immediate)
                speechSynthesizer.speak(speechUtterance)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 24.0) {
                self.presentCircleHint(.end4)
            }
            
            self.collision = Collision(
                with: self.view,
                update: { () -> (blindPerson: BlindCharacter, traffic: Traffic, sidewalks: [Pedestians]) in
                    return (blindPerson: self.blindCharacter, traffic: self.world.road.traffic!, sidewalks: [self.world.topSidewalk.pedestrians!, self.world.bottomSidewalk.pedestrians!])
            },
                whenCollisionDetected: { (object: UIView) in
                    switch object {
                        case is SidewalkElement:
                            if let element = object as? SidewalkElement, (element.type == .bench || element.type == .busStopSign) && !stopIsRitched {
                                stopIsRitched = true
                                let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "You reach the stop, lines: orange will arrive in about a minute. The stop contains the bus sign and the bench. The bus will stop on the street.")
                                speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                speechSynthesizer.stopSpeaking(at: .immediate)
                                speechSynthesizer.speak(speechUtterance)
                        }
                        
                        case is Bus:
                            guard let bus = object as? Bus, bus.line == .orange else { return }
                            UIView.animate(withDuration: 0.5, animations: {
                                self.character.alpha = 0.0
                            }) { (_) in
                                
                        }
                        default:
                            break
                    }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.checkCollision()
            }
        }
    }
}
