//
//  LiveView.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import PlaygroundSupport
import UIKit
import City

let viewController = CityViewController()
viewController.createStaticPage4()

PlaygroundPage.current.liveView = viewController
