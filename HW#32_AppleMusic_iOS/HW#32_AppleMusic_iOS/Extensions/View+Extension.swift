//
//  View+ExtensionFile.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/14.
//

import Foundation
import UIKit

extension UIView {
    
    func viewZoomIOut () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.72, y: 0.72)
    }
    func viewZoomIn () {
        self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
    }
    
}
