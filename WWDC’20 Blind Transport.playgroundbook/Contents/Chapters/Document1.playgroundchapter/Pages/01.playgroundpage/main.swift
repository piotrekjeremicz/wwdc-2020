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
        case .timetable1:
            page.assessmentStatus = .pass(message: "🧑🏻‍🦱: My bus is coming! I can't miss it.")
        case .end1:
            page.assessmentStatus = .pass(message: "Cool! Peter is on his way to work. Time to move to the next location. [Go to the next page](@next)")
        default:
            break;
    }
}

viewController.startPage1()
//#-end-hidden-code

/*:
 # The bus stop
 ## Peter's everyday life
 Every day at 8:30 Peter leaves his home to catch the bus 🚌 and go to work 💼. Like many people in his city 🏙, he repeats this action to enjoy life and spend some time with the wife in a park 🌳, restaurant 🍣 or cinema 📽 in Downtown.
 
 This Playground Book will guide us through the public transport user for one day.
 
 ## Quick intro
 Before we will take our bus, we need to learn how to be as a Peter 🧑🏻‍🦱.
 -  Touch/press the screen to enable joystick and swipe around 🕹 - this is how we will walk around 🚶🏻‍♂️.
 -  We need to catch the Orange Line Bus 🔸 - try to check the timetable that is hanging near the bench 🚏🪑.
 -  When the bus will arrive you can walk into it.
 
 ## Are you ready?
 Tap **Run my code** to start the first adventure!
 
 * callout(Tip):
Remember: if you want to read the timetable or enter the bus the "white person" should get in touch with the object. You can manipulate the man in the white shirt by the joystick.
*/
