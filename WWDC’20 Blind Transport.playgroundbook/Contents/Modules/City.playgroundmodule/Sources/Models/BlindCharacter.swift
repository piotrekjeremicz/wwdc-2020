//
//  BlindCharacter.swift
//  Blind Transport
//
//  Created by Piotrek on 18/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit

public class BlindCharacter: UIImageView {
    
    public var isIddle = true
    public var isWalking = false
    public var direction: ControllerDirection = .none
    
    public var size: CGSize {
        return CGSize(width: 44.0, height: 40.0)
    }
    
    public init() {
        super.init(frame: .zero)
        
        frame.size = size
        animationDuration = 0.8
        animationRepeatCount = 0
        contentMode = .scaleAspectFit
        
        image = UIImage.init(named: "blind_1")
        animationImages = [
            UIImage.init(named: "blind_0")!,
            UIImage.init(named: "blind_1")!,
            UIImage.init(named: "blind_2")!
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showMind(string: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let label = UILabel(frame: .init(x: 4.0 + self.size.width, y: 0.0, width: 200.0, height: 40.0))
            label.text = string
            label.alpha = 0.0
            label.transform = .init(scaleX: 0.6, y: 0.6)
            label.font = .systemFont(ofSize: 32.0)
            
            self.addSubview(label)
            
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                label.alpha = 1.0
                label.transform = .identity
            }, completion: {
                (_) in
                UIView.animate(withDuration: 1.0, delay: 6.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                    label.alpha = 0.0
                    label.transform = .init(scaleX: 0.6, y: 0.6)
                }, completion:  {
                    (_) in
                    label.removeFromSuperview()
                })
            })
        }
        
    }
    
    public func move() {
        guard !isWalking else { return }
        
        let step: CGFloat = 40.0
        var nextPoint = center
        
        switch direction {
            case .left:
                nextPoint = .init(x: center.x - step, y: center.y)
                transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
            case .top:
                nextPoint = .init(x: center.x, y: center.y - step)
                transform = CGAffineTransform(rotationAngle: (270.0 * .pi) / 180.0)
            case .right:
                nextPoint = .init(x: center.x + step, y: center.y)
                transform = .identity
            case .bottom:
                nextPoint = .init(x: center.x, y: center.y + step)
                transform = CGAffineTransform(rotationAngle: (90.0 * .pi) / 180.0)
            case .none:
                break;
        }
        
        isWalking = true
        startAnimating()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
            self.center = nextPoint
        }) { (_) in
            self.stopAnimating()
            self.isWalking = false
            
            if !self.isIddle {
                self.move()
            }
        }
    }
}
