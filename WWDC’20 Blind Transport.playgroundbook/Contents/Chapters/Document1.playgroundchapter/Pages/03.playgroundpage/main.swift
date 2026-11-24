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
        case .busStop:
            page.assessmentStatus = .pass(message: "🧑🏻‍🦯: It was not that bad. I hope I came to a good stop... Right now I will wait for the blue line 🔹")
        case .end3:
            page.assessmentStatus = .pass(message: "Blurry colors and indistinct contours made it possible to find a stop. What would happen if it were going completely blind? [Go to the next page](@next)")
        default:
            break;
    }
}

viewController.startPage3()
viewController.setVision(for: .bluredVision)
//#-end-hidden-code

/*:
 # The Crowded City
 ## eVERYDAY rOUTINE
 The same place, but this time everything will turn upside down 🙃. This time after pressing start will not be like before 😳.
 
 You will start on the same place that last time. The traffic will be low 🦻. Try to walk to the bus stop and take the blue line 🔹.
 
 * callout(Tip):
Look closer - the person will display the red exclamation marks. He is confused. It could help you to find the place where he is. Go right to the bus stop.
*/
