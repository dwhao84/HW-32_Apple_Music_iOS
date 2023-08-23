//
//  MusicPlayerViewController.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/8.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit
import AVRouting

class MusicPlayerViewController: UIViewController, AVRoutePickerViewDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var musicCoverImageView: UIImageView!

    @IBOutlet weak var songNameBtn: UILabel!
    @IBOutlet weak var artistsLabel: UILabel!

    @IBOutlet weak var musicStartDurationLabel: UILabel!
    @IBOutlet weak var musicDurationEndLabel: UILabel!

    @IBOutlet weak var moreBtn: UIButton!

    @IBOutlet weak var louderBtn: UIButton!
    @IBOutlet weak var dieDownBtn: UIButton!

    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!

    @IBOutlet weak var quoteBtn: UIButton!
    @IBOutlet weak var airPlayBtn: UIButton!
    @IBOutlet weak var listBtn: UIButton!

    @IBOutlet weak var songLengthSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!

    let time = CMTime()

    let player = AVPlayer()

    let routePickerView = AVRoutePickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI ()
        musicPlayAutomatically ()
        statusBtn.setPauseBtn()
        routePickerView.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            view.addGestureRecognizer(tapGesture)


    }

    //morebtn
    @IBAction func moreBtnTapped(_ sender: UIButton) {
        moreBtnMenuSetup ()
        print("moreBtnTapped")
    }


    //songDuration
    @IBAction func songDurationSlider(_ sender: UISlider) {

    }

    //volumeSlider coordinate with slider's value.
    @IBAction func volumeSliderValueChanged(_ sender: UISlider) {
        player.volume = Float(volumeSlider.value)
    }

    //airPlayer tapped
    @IBAction func airPlayerBtnTapped(_ sender: UIButton) {
        setupRoutePickerView()
    }

    //forwardBtn tapped
    @IBAction func forwardBtnTapped(_ sender: UIButton) {

    }

    //backwardBtn
    @IBAction func backwardBtnTapped(_ sender: UIButton) {

    }

    //Change the mode when Btn is play or pause.
    @IBAction func statusBtnTapped(_ sender: UIButton) {
        if player.timeControlStatus == .playing {
            player.pause()
            statusBtn.setupPlayBtn()
            musicCoverImageView.imageViewZoomIOut()
            print("now is pause")
        } else {
            player.play()
            statusBtn.setPauseBtn()
            print("now is play")
            musicCoverImageView.imageViewZoomIn()
        }
    }

    //When btnTouchDown scale changed, change to smaller or bigger
    @IBAction func btnTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.statusBtn.setupBtnWhenTappedBecomeSmaller()
            print("btn smaller")
        }
        statusBtn.setupBtnWhenTappedBecomeNormal()
        print("btn normal")
    }

    //forwardBtn Touch Down(hold btn)
    @IBAction func forwardBtnTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.forwardBtn.frame = CGRect(x: 285, y: 693, width: 75, height: 50)
            self.forwardBtn.setupBtnWhenTappedBecomeDispear()
            print("btn smaller")
        }
        forwardBtn.frame = CGRect(x: 285, y: 693, width: 70, height: 50)
        forwardBtn.setupBtnWhenTappedBecomeNormal()
        print("btn normal")
    }

    //backwardBtn Touch Down(hold btn)
    @IBAction func backwardBtnTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.backwardBtn.frame = CGRect(x: 74, y: 693, width: 75, height: 50)
            self.backwardBtn.setupBtnWhenTappedBecomeDispear()
            print("btn smaller")
        }
        backwardBtn.frame = CGRect(x: 74, y: 693, width: 70, height: 50)
        backwardBtn.setupBtnWhenTappedBecomeNormal()
        print("btn normal")
    }

    @IBAction func volumeSliderAndIconTouchDown(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {

        }
    }

    //Playing music
    func musicPlayAutomatically () {
        //Generate the music in URL
        let url = Bundle.main.url(forResource: "rocking chair", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)

        //Set up music for AVPlayerItem
        player.replaceCurrentItem(with: playerItem)

        //Play Music
        player.play()
        print("Song is playing")
    }


    func timeConverter(min: Float, sec: Float) -> Float {
        let totalSeconds = min * 60 + sec
        return totalSeconds
    }


    func updateUI () {
        //Add gradientBackgroundColor
        setupGradientBackground()

        //Add cornerRadius for imageView
        musicCoverImageView.image = UIImage(named: "wavcrushRockingChair")
        musicCoverImageView.customUIImageView()
        //Add shadow for imageView
        containerView.customUIView()

        //Add height for Slider
        songLengthSlider.customSongLengthSlider()
        volumeSlider.customVolumeSlider()

        //Add Alpha for btn
        quoteBtn.addBtnAlpha()
        airPlayBtn.addBtnAlpha()
        listBtn.addBtnAlpha()

        //Add Alpha for label
        artistsLabel.addLabelAlphaSec()
        musicStartDurationLabel.addLabelAlpha()
        musicDurationEndLabel.addLabelAlpha()

        //Add playBtn
        statusBtn.setupPlayBtn()
    }

    //Add gradientBackgroundColor
    func setupGradientBackground() {
         //Call gradientLayer as CAGradientLayer.
         let gradientLayer = CAGradientLayer()
         //Same frame as view
         gradientLayer.frame = view.bounds
         //Setup Gradient Color
         gradientLayer.colors = [
            UIColor(red: 71/255, green: 85/255, blue: 118/255, alpha: 1.0).cgColor,
            UIColor(red: 70/255, green: 85/255, blue: 111/255, alpha: 1.0).cgColor,
            UIColor(red: 43/255, green: 52/255, blue: 69/255, alpha: 1.0).cgColor
        ]
         //add the view in the bottom view
         view.layer.insertSublayer(gradientLayer, at: 0)
    }

    //Add when moreBtn tapped Menu shows up
    //moreBtn the proiority is upside down, beware of that!
    func moreBtnMenuSetup () {
        moreBtn.showsMenuAsPrimaryAction = true
        moreBtn.menu = UIMenu(children: [
                    UIAction(title: "Suggest Less", image: UIImage(systemName: "hand.thumbsdown"), handler: { action in
                             print("Suggest Less")
                    }),
                    UIAction(title: "Love", image: UIImage(systemName: "heart"), handler: { action in
                             print("Love")
                    }),
                    UIMenu(options: .displayInline, children: [
                        UIAction(title: "Create Station", image: UIImage(systemName: "badge.plus.radiowaves.right"),  handler: { action in
                            print("Create Station")
                        }),
                        UIAction(title: "Show Album", image: UIImage(systemName: "play.square"), handler: { action in
                            print("Show Album")
                        }),
                        UIAction(title: "Share Lyrics", image: UIImage(systemName: "quote.bubble") ,handler: { action in
                            print("Share Lyrics")
                        }),
                        UIAction(title: "View Full Lyrics", image: UIImage(systemName: "quote.bubble"), handler: { action in
                            print("View Full Lyrics")
                        }),
                        UIAction(title: "SharePlay", image: UIImage(systemName: "shareplay"), handler: { action in
                            print("SharePlay")
                        }),
                        UIAction(title: "Share Song", image: UIImage(systemName: "square.and.arrow.up"), handler: { action in
                            print("Share Song")
                        })
                    ]),
                    UIMenu(options: .displayInline, children: [
                        UIAction(title: "Add to Library", image: UIImage(systemName: "plus"), handler: { action in
                            print("Add to Library")
                        }),
                        UIAction(title: "Add to a Playlist", image: UIImage(systemName: "text.badge.plus"), handler: { action in
                            print("Add to a Playlist")
                        })
                ])
        ])
    }

    //Setup Route PickerView
    func setupRoutePickerView() {
        routePickerView.frame = CGRect(x: 184, y: 433, width: 60, height: 60)
        routePickerView.tintColor = .white
        routePickerView.activeTintColor = .white
        routePickerView.backgroundColor = .black
        routePickerView.isUserInteractionEnabled = true
        view.addSubview(routePickerView)
    }

    //Add @objc func for Tap Gesture Recogniser
    @objc func handleTap() {
        routePickerView.isHidden = true
    }


}

//import AVFoundation
//import CoreMedia



