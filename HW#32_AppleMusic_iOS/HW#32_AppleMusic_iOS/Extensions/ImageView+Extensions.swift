//
//  ImageView+Extensions.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/14.
//

import Foundation
import UIKit

// Add cornerRadius for ImageView
extension UIImageView {
    func customUIImageView() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.cornerRadius = 30
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.clipsToBounds = true
    }

    // When Music stop, the cover will zoom out.
    func imageViewZoomIOut () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.72, y: 0.72)
    }
    // When Music stop, the cover will zoom in.
    func imageViewZoomIn () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
    }
}
