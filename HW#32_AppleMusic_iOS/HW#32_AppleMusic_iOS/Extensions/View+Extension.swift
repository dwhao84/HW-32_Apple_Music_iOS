//
//  View+ExtensionFile.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/14.
//

import Foundation
import UIKit

extension UIView {
    func customUIView() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.cornerRadius = self.frame.midX/30
        self.clipsToBounds = true
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 100
    }
}
