//
//  Car.swift
//  Blind Transport
//
//  Created by Piotrek on 14/05/2020.
//  Copyright © 2020 Piotr Jeremicz. All rights reserved.
//

import UIKit
import AVFoundation

public enum VehicleType: CaseIterable {
    case grayCar
    case yellowCar
    case redCar
    case pinkCar
    case greenCar
}

public enum VehicleDirection: CaseIterable {
    case left
    case right
}

public enum VehicleSound: String, CaseIterable {
    case engine1 = "car_engine_1"
    case engine2 = "car_engine_2"
    case engine3 = "car_engine_3"
    
}

public class Vehicle: UIImageView {
    public let type: VehicleType
    public let direction: VehicleDirection
    
    public var engine : AVPlayer?
    
    public var size: CGSize {
        return CGSize(width: 120.0, height: 160.0)
    }
    
    public init(type: VehicleType, direction: VehicleDirection) {
        self.type = type
        self.direction = direction
        
        super.init(frame: .zero)
        frame.size = size
        layer.zPosition = 1000
        contentMode = .scaleAspectFit
        
        switch self.type {
            case .grayCar:
                image = UIImage.init(named: "car_gray")
            case .yellowCar:
                image = UIImage.init(named: "car_yellow")
            case .redCar:
                image = UIImage.init(named: "car_red")
            case .pinkCar:
                image = UIImage.init(named: "car_pink")
            case .greenCar:
                image = UIImage.init(named: "car_green")
        }
        
        if self.direction == .left {
            image = image?.withHorizontallyFlippedOrientation()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startEngine() {
        let sound = VehicleSound.allCases.randomElement()!
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "m4a") else { return }
        
        let asset = AVAsset(url: url) as AVAsset
        
        let duration = asset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)
        
        let item = AVPlayerItem(asset: asset)
        let params = AVMutableAudioMixInputParameters(track: asset.tracks.first! as AVAssetTrack)
        
        let firstSecond = CMTimeRangeMake(
            start: CMTimeMakeWithSeconds(0, preferredTimescale: 1),
            duration: CMTimeMakeWithSeconds(3, preferredTimescale: 1))
        
        let lastSecond = CMTimeRangeMake(
            start: CMTimeMakeWithSeconds(durationInSeconds - 3, preferredTimescale: 1),
            duration: CMTimeMakeWithSeconds(3, preferredTimescale: 1))
        
        params.setVolumeRamp(fromStartVolume: 0, toEndVolume: 1, timeRange: firstSecond)
        params.setVolumeRamp(fromStartVolume: 1, toEndVolume: 0, timeRange: lastSecond)
        
        let mix = AVMutableAudioMix()
        mix.inputParameters = [params]
        item.audioMix = mix
        
        
        engine = AVPlayer()
        engine?.replaceCurrentItem(with: item)
        
        switch sound {
            case .engine1:
                engine?.volume = 1.0
            case .engine2:
                engine?.volume = 0.4
            case .engine3:
                engine?.volume = 0.6
        }

        engine?.play()
    }
    
    public func stopEngine() {
        engine?.pause()
        engine = nil
    }
}
