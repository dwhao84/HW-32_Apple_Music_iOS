//
//  Slider+Extensions.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/14.
//

import Foundation
import UIKit

extension UISlider {
    func customSongLengthSlider () {
        self.frame = CGRect(x: 26, y: 592, width: 380, height: 30)
        self.thumbTintColor = .clear
        self.minimumValue = 0.1
        self.value = 0.0
        self.maximumValue = 1
    }

    func customVolumeSlider () {
        self.frame = CGRect(x: 64, y: 800, width: 300, height: 30)
        self.thumbTintColor = .clear
        self.minimumValue = 0.1
        self.value = 0.5
        self.maximumValue = 1
    }

    func setupSliderWhenTappedBecomeLarger () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.9 , y: 0.9)
    }

    func setupSliderWhenTappedBecomeNormal () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 1  , y: 1)
    }
}
