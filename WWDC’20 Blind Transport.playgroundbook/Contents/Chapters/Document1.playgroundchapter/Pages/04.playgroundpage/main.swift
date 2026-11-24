//#-hidden-code
//
//  main.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import PlaygroundSupport
import UIKit
import City

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true

let viewController = CityViewController()
page.liveView = viewController

viewController.presentPlaygroundHint { (type) in
    switch type {
        case .end4:
            page.assessmentStatus = .pass(message: "You did it! 🎉 Thank you very much for participating in the short story of the public transport user. I hope that these four simple situations have shown how complicated public transport is and how much focus should be put on the passenger's comfort - every passenger.")
        default:
            break;
    }
}

viewController.startPage4()
viewController.setVision(for: .totalBlindness)
//#-end-hidden-code

/*:
 # Show By Speaking
 ## The hardest way
 Sometimes the obvious things seem so real that we don't even think that it could be different 🙅‍♂️.
 
 We will make the last walk, again near Peter's house 🧑🏻‍🦯. This time we will try to get on the orange line bus but this time the line colour does not matter ▪️. Listening and analysis will be much more needed this time 🦻.
 
 This time, however, we will not be alone 🦾.
 
 * callout(Tip):
 Remember to turn on the sound. The voice assistant guides you to the bus stop. You can not see anything - joystick is hidden too. Be patient and you will find the bus stop! Go right until the assistant informs you that you have reached the bus stop.
*/
