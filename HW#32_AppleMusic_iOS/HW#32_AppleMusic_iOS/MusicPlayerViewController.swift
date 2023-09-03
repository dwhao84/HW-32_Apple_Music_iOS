//
//  MusicPlayerViewController.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/8.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import AVRouting

class MusicPlayerViewController: UIViewController, AVAudioPlayerDelegate, AVRoutePickerViewDelegate {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var musicCoverImageView: UIImageView!

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistsLabel: UILabel!

    @IBOutlet weak var songDurationStartLabel: UILabel!
    @IBOutlet weak var songDurationEndLabel: UILabel!

    @IBOutlet weak var moreBtn: UIButton!

    @IBOutlet weak var louderBtn: UIButton!
    @IBOutlet weak var dieDownBtn: UIButton!

    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!

    @IBOutlet weak var lyrisBtn: UIButton!
    @IBOutlet weak var airPlayBtn: UIButton!
    @IBOutlet weak var listBtn: UIButton!

    @IBOutlet weak var songLengthSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!

    let player = AVPlayer()

    // setup routePickerView
    let routePickerView = AVRoutePickerView()
    // setup routeDetector
    let routeDetector = AVRouteDetector()

    var index = 0

    var backwardBtnTappedCount = 0

    var timeObserverToken: Any?

    var playerItem: AVPlayerItem?

    // Add gradinentBackground color album.
    let gradientLayer = CAGradientLayer()
    // Setup cornRadius's value.
    let cornerRadius: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI ()
        playMusicAutomatically ()

        // Setup AirPlayButton
        routePickerView.delegate = self
        setupAirplayButton()

        observeSongTimeUpdates()
        artistsLabel.adjustsFontSizeToFitWidth = true
        songNameLabel.adjustsFontSizeToFitWidth = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    // Setup songLengthThumbImage
    func setupSongLengthThumbImage () {
        let configuration = UIImage.SymbolConfiguration(pointSize: 8)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        songLengthSlider.setThumbImage(image, for: .normal)
    }
    
    // Setup VolumeSliderThumbImage
    func setupVolumeSliderThumbImage () {
        let configuration = UIImage.SymbolConfiguration(pointSize: 8)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        volumeSlider.setThumbImage(image, for: .normal)
    }

    // Playing music
    func playMusicAutomatically () {

        // Create index change for songList
        index = (index + songList.count) % songList.count

        // Build the song's location
        let url = Bundle.main.url(forResource: songList[index].songName, withExtension: "mp3")!

        // Song location login to AVPlayerItem
        playerItem = AVPlayerItem(url: url)

        // replace current item with a new item.
        player.replaceCurrentItem(with: playerItem)

        // play song.
        player.play()

        // musicCoverImageView's image changed by index.
        musicCoverImageView.image = UIImage(named: songList[index].coverName)

        // artistsLabel's content changed by index.
        artistsLabel.text = songList[index].artist

        // songNameLabel's content changed by index.
        songNameLabel.text = songList[index].songName

        // Same frame as view
        gradientLayer.frame = view.bounds

        // gradientLayerColor's color changed by index.
        gradientLayer.colors =  songList[index].backGroundColor

        // add the view in the bottom view which's layer no.0
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func updateUI () {
        musicCoverImageView.layer.cornerRadius = cornerRadius
        musicCoverImageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        musicCoverImageView.clipsToBounds = true

        subView.layer.cornerRadius = cornerRadius
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        subView.layer.shadowRadius = 25.0
        subView.layer.shadowOpacity = 0.5

        subView.layer.shadowPath = UIBezierPath(roundedRect: musicCoverImageView.bounds, cornerRadius: cornerRadius).cgPath

        // Add height for Slider
        songLengthSlider.customSongLengthSlider()
        volumeSlider.customVolumeSlider()
        setupSongLengthThumbImage ()
        setupVolumeSliderThumbImage ()

        // Add Alpha for btn
        lyrisBtn.addBtnAlpha()
        airPlayBtn.addBtnAlpha()
        listBtn.addBtnAlpha()

        // Add Alpha for label
        artistsLabel.addLabelAlphaSec()

        // Setup SongDurationStartLabel
        songDurationStartLabel.text = "--:--"
        songDurationStartLabel.addLabelAlpha()

        // Setup SongDurationEndLabel
        songDurationEndLabel.text = "--:--"
        songDurationEndLabel.addLabelAlpha()

        // UI for playBtn
        statusBtn.setupPlayBtn()
        statusBtn.setPauseBtn()

        //LyrisBtn trigger
        lyrisBtn.addTarget(self, action: #selector(buttonTouchUp), for: .touchDown)
        lyrisBtn.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])

        //airPlayBtn trigger
        airPlayBtn.addTarget(self, action: #selector(buttonTouchUp), for: .touchDown)
        airPlayBtn.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])

        listBtn.addTarget(self, action: #selector(buttonTouchUp), for: .touchDown)
        listBtn.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }

    // Add when moreBtn tapped Menu shows up
    // moreBtn the proiority is upside down, beware of that!
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

    // Setup Route PickerView
    func setupAirplayButton() {
        //routePickerView frame size.
        routePickerView.frame = CGRect(x: 174, y: 600, width: 80, height: 80)

        //Set up UI for routePickerView
        routePickerView.activeTintColor = UIColor.systemPink
        routePickerView.backgroundColor = UIColor.black
        routePickerView.tintColor = UIColor.white

        //addSubview for routePickerView
        self.view.addSubview(routePickerView)
    }

    //Detect routePickerView
    func handleRouteChange(notification: Notification) {
        if routeDetector.multipleRoutesDetected {
            // Show your AVRoutePickerView or make any necessary updates.
            routePickerView.isHidden = false
        } else {
            // Hide your AVRoutePickerView or make other necessary adjustments.
            routePickerView.isHidden = true
        }
    }

    func routePickerViewDidEndPresentingRoutes(_ routePickerView: AVRoutePickerView) {
    }

    func routePickerViewWillBeginPresentingRoutes(_ routePickerView: AVRoutePickerView) {
    }

    // Add an @objc function for the Tap Gesture Recognizer to be triggered when AirPlay is open and the user touches the view.
    @objc func handleTap() {
        routePickerView.isHidden = true
    }

    func setupCommandCenter() {
        // Get the shared command center.
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add a handler for the play command.
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.player.rate == 0.0 {
                self.player.play()
                return .success
            }
            return .commandFailed
        }
    }

    func updateSongDuration() async {

        /// Get songDuration by new solution.
        // 1. Define AVURLAsset first.
        let url = Bundle.main.url(forResource: songList[index].songName, withExtension: "mp3")!
        // 2. Store asset from AVURLAsset location.
        let asset = AVURLAsset(url: url, options: nil)
        // 3. Get duration from asset
        let duration = try? await asset.load(.duration) // 注意: `asset.load` 是我們之前討論的，請確保這真的存在。
        // 4. Get total seconds (Float) by type annotation from CMTimeGetSeconds.
        let songDurationSec = CMTimeGetSeconds(duration!)

        // Print out(total DurationSec when song is playing)
        print(songDurationSec)

        ///Get currentTime of song.
        // 1. Get currentSongSecs by using CMTimeGetSeconds
        let currentSongInSecs = CMTimeGetSeconds(self.player.currentTime())
        // 2. Type annotation from float to Int, Int to String.
        let currentSongDurationSec = String(format: "%02d", Int(currentSongInSecs) % 60)
        // 3. Get minutes from float to Int, Int to String.
        let currentSongDurationMin = String(Int(currentSongInSecs) / 60)
        // 4.
        self.songDurationStartLabel.text = "\(currentSongDurationMin):\(currentSongDurationSec)"

        /// Calculate remainSongSec
        let remainSongInSecs = songDurationSec - currentSongInSecs
        // 1. Same from top solution to get total second.
        let remainSongDurationSec = String(format: "%02d", Int(remainSongInSecs) % 60)
        // 2. Same from top solution to get minutes.
        let remainSongDurationMin = String(Int(remainSongInSecs) / 60)

        // Print out(songDurationSec when song is playing)
        self.songDurationEndLabel.text = "-\(remainSongDurationMin):\(remainSongDurationSec)"

        /// setup songLengSlider from songDurationSec
        songLengthSlider.maximumValue = Float(songDurationSec)
        songLengthSlider.value = Float(currentSongInSecs)
    }

        ///Use the player addPeriodicTimeObserver to observe the TIME and set up second equals 1 and  TimeScale count by per second.
        func observeSongTimeUpdates() {
            player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: .main) { [weak self] _ in
            Task {
                await self?.updateSongDuration()
            }
        }
    }

    // trigger morebtn
    @IBAction func moreBtnTapped(_ sender: UIButton) {
        moreBtnMenuSetup ()
        print("moreBtnTapped")
    }

    // trigger songDuration
    // Seek means requests that the player seek to a specified time.
    @IBAction func songDurationSlider(_ sender: UISlider) {
        let currentSec = Int64(sender.value)
        let targetTime = CMTimeMake(value: currentSec, timescale: 1)
        player.seek(to: targetTime)
    }

    // volumeSlider coordinate with slider's value.
    @IBAction func volumeSliderValueChanged(_ sender: UISlider) {
        player.volume = Float(volumeSlider.value)
    }

    // airPlayer tapped
    @IBAction func airPlayerBtnTapped(_ sender: UIButton) {
        setupAirplayButton()
        print("airPlayerBtnTapped")
    }

    // forwardBtn tapped
    @IBAction func forwardBtnTapped(_ sender: UIButton) {
        index += 1
        print(index)
        playMusicAutomatically ()
        print("forwardBtnTapped")
    }

    // trigger backwardBtn
    @IBAction func backwardBtnTapped(_ sender: UIButton) {
        backwardBtnTappedCount += 1
        if backwardBtnTappedCount == 1 {
            player.seek(to: .zero)
            playMusicAutomatically ()
            print("backwardBtnTappedCount equal 1")
        } else if backwardBtnTappedCount >= 1 {
            index -= 1
            print(index)
            playMusicAutomatically ()
            print("backwardBtnTappedCount greater than 1")
        }
    }

    // Change the mode when Btn is play or pause.
    @IBAction func statusBtnTapped(_ sender: UIButton) {
        if player.timeControlStatus == .playing {
            player.pause()
            statusBtn.setupPlayBtn()
            subView.viewZoomIOut()
            print("now is pause")
        } else if player.timeControlStatus == .paused {
            player.play()
            statusBtn.setPauseBtn()
            subView.viewZoomIn()
            print("now is play")
        }
    }

    // When touch down the stautsBtn trigger btnTouchDown, let btn size change to smaller or bigger
    @IBAction func btnTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.statusBtn.setupBtnWhenTappedBecomeSmaller()
            print("btn smaller")
        }
        statusBtn.setupBtnWhenTappedBecomeNormal()
        print("btn normal")
    }

    @objc func buttonTouchDown(_ sender: UIButton) {
        sender.setupBtnTouchDown()
    }

    @objc func buttonTouchUp(_ sender: UIButton) {
        sender.setupBtnTouchDownRecover ()
    }

}


