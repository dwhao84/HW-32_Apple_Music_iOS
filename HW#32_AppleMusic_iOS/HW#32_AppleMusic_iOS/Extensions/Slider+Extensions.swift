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
        self.minimumValue = 1
        self.value = 1
        self.maximumValue = 10
    }

    func customVolumeSlider () {
        self.frame = CGRect(x: 64, y: 800, width: 300, height: 30)
        self.thumbTintColor = .clear
        self.minimumValue = 1
        self.value = 1
        self.maximumValue = 10
    }

    func setupSliderWhenTappedBecomeLarger () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.9 , y: 0.9)
    }

    func setupSliderWhenTappedBecomeNormal () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 1  , y: 1)
    }

}
