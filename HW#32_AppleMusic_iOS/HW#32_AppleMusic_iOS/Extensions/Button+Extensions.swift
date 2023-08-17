//
//  Button+Extensions.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/14.
//

import Foundation
import UIKit

//Add ALPHA for btn
extension UIButton {
    func addBtnAlpha () {
        self.alpha = 0.5
    }

    func addBtnAlphaWithoutLyris () {
        self.alpha = 0.2
    }
    //setup Play btn
    func setupPlayBtn () {
        self.setImage(UIImage(systemName: "play.fill"), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 34)
    }
    //set Pause btn
    func setPauseBtn () {
        self.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 34)
    }

    //setup when Btn tapped become smaller
    func setupBtnWhenTappedBecomeSmaller () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 3  , y: 3)
    }

    func setupBtnWhenTappedBecomeNormal () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
    }

    func setupBtnWhenTappedBecomeDispear () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 10, y: 10)
    }

    func setupBtnTouchDownBecomeLarge () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
    }
}
