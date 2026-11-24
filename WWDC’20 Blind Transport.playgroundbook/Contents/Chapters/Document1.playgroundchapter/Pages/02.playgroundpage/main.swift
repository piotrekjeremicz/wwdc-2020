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
        case .late:
            page.assessmentStatus = .pass(message: "🧑🏻‍🦱: Oh no, my bus has run away! I should check timetable... I will be late home again...")
        case .timetable2:
            page.assessmentStatus = .pass(message: "🧑🏻‍🦱: A few minutes and the orange line will come again. Hmmm, there is a blind man at the bus stop. Maybe I'll help him ...")
        case .blueLineIsArrive:
            page.assessmentStatus = .pass(message: "🧑🏻‍🦱: Excuse me sir. The blue line is coming.")
        case .orangeLineIsArrive:
            page.assessmentStatus = .pass(message: "🧑🏻‍🦱: I hope this blind gentleman will get home calmly. Oh my bus is coming too! Today I am lucky!")
        case .end2:
            page.assessmentStatus = .pass(message: "Good deeds come back to us quickly. Peter got home faster. What if the roles were reversed? [Go to the next page](@next)")
        default:
            break;
    }
}

viewController.startPage2()
//#-end-hidden-code

/*:
 # The Crowded City
 ## Everyday routine
 Public transport is the bloodstream of the city 🩸. It must be efficient, fast and helpful for every resident 🏘. However, as often happens, sometimes we need to run to the bus without noticing the problems of the world around us 🙈.
 
 * callout(Tip):
 Look around - maybe there is someone that needs an assistant or help.
 
 ## Peter is late
 Tap **Run my code** to see that this time Peter is too late and could not catch the bus 😓. See who will rise on his road and how you can help him 🙏.
*/
