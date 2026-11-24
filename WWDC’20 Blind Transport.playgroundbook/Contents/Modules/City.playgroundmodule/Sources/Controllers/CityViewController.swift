//
//  CityViewController.swift
//  Blind Transport
//
//  Created by Piotrek on 11/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public class CityViewController: UIViewController {

    var world: World = World()
    
    let controller = Controller()
    let character = MainCharacter()
    let blindCharacter = BlindCharacter()
    
    var collision: Collision?
    
    var hintImageView: UIImageView?
    var hintAction: ((_ type: HintType) -> Void)?
    var lastHintType: HintType?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 150.0/255.0, green: 172.0/255.0, blue: 11.0/255.0, alpha: 1.0)
    }
    
    public func create(world: World) {
        view.subviews.forEach { (view) in view.removeFromSuperview() }

        view.addSubview(world.road)
        view.addSubview(world.topSidewalk)
        view.addSubview(world.bottomSidewalk)
        
        if let elements = world.topSidewalk.elements {
            view.addSubview(elements.centerElement)
            elements.leftElements.forEach { (element) in view.addSubview(element) }
            elements.rightElements.forEach { (element) in view.addSubview(element) }
        }
        
        if let accessory = world.topSidewalk.accessory {
            world.topSidewalk.addSubview(accessory)
        }
        
        if let elements = world.bottomSidewalk.elements {
            view.addSubview(elements.centerElement)
            elements.leftElements.forEach { (element) in view.addSubview(element) }
            elements.rightElements.forEach { (element) in view.addSubview(element) }
        }
        
        if let accessory = world.bottomSidewalk.accessory {
            world.bottomSidewalk.addSubview(accessory)
        }
        
        world.topEnvironment.forEach { (building) in view.addSubview(building) }
        world.bottomEnvironment.forEach { (building) in view.addSubview(building) }
        
        NSLayoutConstraint.activate(world.createConstraintArray(for: view))
    }
}

extension CityViewController {
    public enum VisionLevel {
        case totalVision
        case bluredVision
        case totalBlindness
    }
    
    public func setVision(for vision: VisionLevel) {
        if vision == .bluredVision {
            let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            blurredView.frame = .init(x: 0.0, y: 0.0, width: 5000.0, height: 5000.0)
            blurredView.alpha = 0.0
            blurredView.layer.zPosition = 999999
            view.addSubview(blurredView)
            
            NSLayoutConstraint.activate([
                blurredView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
                blurredView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
                blurredView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
                blurredView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0),
            ])
            
            
            UIView.animate(withDuration: 0.5) {
                blurredView.alpha = 1.0
            }
        } else if vision == .totalBlindness {
            let blurredView = UIView.init(frame: .init(x: 0.0, y: 0.0, width: 5000.0, height: 5000.0))
            blurredView.backgroundColor = .black
            blurredView.alpha = 0.0
            blurredView.layer.zPosition = 999999
            view.addSubview(blurredView)
            
            NSLayoutConstraint.activate([
                blurredView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
                blurredView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
                blurredView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
                blurredView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0),
            ])
            
            
            UIView.animate(withDuration: 0.5) {
                blurredView.alpha = 1.0
            }
        }
    }
}

extension CityViewController {
    public enum HintType {
        case timetable1
        case timetable2
        case late
        case blueLineIsArrive
        case orangeLineIsArrive
        case busStop
        case end1
        case end2
        case end3
        case end4
    }
    
    public func presentPlaygroundHint(_ completion: @escaping (_ type: HintType) -> Void) {
        self.hintAction = completion
    }
    
    public func checkCollision() {
        self.collision?.checkCollision(for: self.character)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.checkCollision()
        }
    }
    
    public func presentCircleHint(_ type: HintType) {
        if let hintType = self.lastHintType, hintType == type { return }
        self.lastHintType = type
        
        self.hintAction?(type)
        
        let circleImageView = UIImageView(frame: .init(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
        circleImageView.layer.borderColor = UIColor.systemOrange.cgColor
        circleImageView.layer.borderWidth = 6.0
        circleImageView.layer.cornerRadius = 150.0
        circleImageView.center = .init(x: 170.0, y: 170.0)
        circleImageView.transform = .init(scaleX: 0.6, y: 0.6)
        circleImageView.alpha = 0.0
        circleImageView.backgroundColor = .white
        circleImageView.clipsToBounds = true
        
        switch type {
            case .timetable1:
                circleImageView.image = UIImage(named: "timetable_hint_1")
            case .timetable2:
                circleImageView.image = UIImage(named: "timetable_hint_2")
            case .end1, .end2, .late, .blueLineIsArrive, .orangeLineIsArrive, .end3, .end4, .busStop:
                circleImageView.image = .none
        }
        
        guard circleImageView.image != .none else { return }
        
        self.hintImageView = circleImageView
        
        self.view.addSubview(self.hintImageView!)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
            self.hintImageView?.alpha = 1.0
            self.hintImageView?.transform = .identity
        }, completion: {
            (_) in
            
            UIView.animate(withDuration: 1.0, delay: 6.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                self.hintImageView?.alpha = 0.0
                self.hintImageView?.transform = .init(scaleX: 0.6, y: 0.6)
            }, completion:  {
                (_) in
                self.hintImageView?.removeFromSuperview()
                self.hintImageView = nil
            })
        })
    }
}

extension CityViewController {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard controller.isEnabled else { return }
        guard let point = touches.first?.location(in: view) else { return }
        
        controller.touchStart(from: point, in: view )
        character.isIddle = false
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard controller.isEnabled else { return }
        guard let point = touches.first?.location(in: view) else { return }
        
        controller.touchMoved(to: point)
        character.direction = controller.direction
        character.move()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard controller.isEnabled else { return }
        
        controller.touchEnded()
        character.isIddle = true
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard controller.isEnabled else { return }
        
        controller.touchEnded()
        character.isIddle = true
    }
}
