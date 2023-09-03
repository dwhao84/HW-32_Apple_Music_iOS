//
//  songInfoModel.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/26.
//

import Foundation
import AVFoundation
import UIKit

struct SongInfo {
    var songName : String
    var artist : String
    var coverName : String
    var backGroundColor : [CGColor]
}

let songList = [

    //index == 0
    SongInfo(
        songName: "rocking chair",
        artist: "wavcrush",
        coverName: "wavcrushRockingChair",
        backGroundColor: [
        UIColor(red: 71/255, green: 85/255, blue: 118/255, alpha: 1.0).cgColor,
        UIColor(red: 70/255, green: 85/255, blue: 111/255, alpha: 1.0).cgColor,
        UIColor(red: 43/255, green: 52/255, blue: 69/255, alpha: 1.0).cgColor ]),

    //index == 1
    SongInfo(
        songName: "0755",
        artist: "Lil Jet",
        coverName: "6JET",
        backGroundColor: [
        UIColor(red: 59/255, green: 51/255, blue: 54/255, alpha: 1.0).cgColor,
        UIColor(red: 78/255, green: 62/255, blue: 78/255, alpha: 1.0).cgColor,
        UIColor(red: 46/255, green: 38/255, blue: 54/255, alpha: 1.0).cgColor ]),

    //index == 2
    SongInfo(
        songName: "心如止水",
        artist: "Ice Paper",
        coverName: "成語接龍",
        backGroundColor: [
        UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0).cgColor,
        UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0).cgColor,
        UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0).cgColor ]),
    //index == 3
    SongInfo(
        songName: "Heat Waves",
        artist: "Glass Animals",
        coverName: "Heat Waves",
        backGroundColor: [
        UIColor(red: 143/255, green: 78/255, blue: 174/255, alpha: 1.0).cgColor,
        UIColor(red: 145/255, green: 77/255, blue: 174/255, alpha: 1.0).cgColor,
        UIColor(red: 123/255, green: 80/255, blue: 169/255, alpha: 1.0).cgColor,
        UIColor(red: 75/255, green: 61/255, blue: 112/255, alpha: 1.0).cgColor ])
]
