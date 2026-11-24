//
//  Bus.swift
//  Blind Transport
//
//  Created by Piotrek on 16/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit
import AVKit

public enum BusLine {
    case orange
    case blue
}

public class Bus: UIImageView {
    public let line: BusLine
    public var engine : AVPlayer?
    
    public var size: CGSize {
        return CGSize(width: 334, height: 102)
    }
    
    public init(line: BusLine) {
        self.line = line
        super.init(frame: .zero)
        
        frame.size = size
        layer.zPosition = 100
        contentMode = .scaleAspectFit
        
        switch self.line {
            case .orange:
                image = UIImage.init(named: "bus_orange")
            case .blue:
                image = UIImage.init(named: "bus_blue")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startEngine() {
        guard let url = Bundle.main.url(forResource: "bus_move", withExtension: "m4a") else { return }
        
        let asset = AVAsset(url: url) as AVAsset
        let item = AVPlayerItem(asset: asset)
        
        engine = AVPlayer()
        engine?.replaceCurrentItem(with: item)
        
        engine?.play()
    }
    
    public func iddleEngine() {
        engine?.pause()
        engine = nil
        
        guard let url = Bundle.main.url(forResource: "bus_iddle", withExtension: "m4a") else { return }
        
        let asset = AVAsset(url: url) as AVAsset
        let item = AVPlayerItem(asset: asset)
        
        engine = AVPlayer()
        engine?.replaceCurrentItem(with: item)
        
        engine?.play()
    }
    
    public func stopEngine() {
        engine?.pause()
        engine = nil
    }
}
