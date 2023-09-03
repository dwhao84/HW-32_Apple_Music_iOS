//
//  ClassOfSliderHeight+Extension.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/27.
//

import Foundation
import UIKit
class CustomHeightSlider: UISlider {
    
    var customTrackHeight: CGFloat = 2.0

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        // Keep the origin and width, change the height
        return CGRect(x: 0, y: bounds.midY - customTrackHeight/2, width: bounds.width, height: customTrackHeight)
    }
}

