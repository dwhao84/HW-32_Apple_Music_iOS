//
//  ViewController.swift
//  123
//
//  Created by Dawei Hao on 2023/8/15.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit
import AVRouting

class ViewController: UIViewController, AVRoutePickerViewDelegate {

    @IBOutlet var airPlayView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    @IBAction func acton(_ sender: Any) {
        setAirplayButton()
    }

    func setAirplayButton() {
        // Create the button view
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

        // Create the route picker view and set its properties
        let routerPickerView = AVRoutePickerView(frame: buttonView.bounds)
        routerPickerView.tintColor = UIColor.green
        routerPickerView.activeTintColor = .white
        routerPickerView.backgroundColor = .black

        // Add the route picker view to the button view
        buttonView.addSubview(routerPickerView)

        // Add the button view to airPlayView
        self.airPlayView.addSubview(buttonView)
    }
}

