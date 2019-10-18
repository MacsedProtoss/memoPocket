//
//  DetailView.swift
//  memoPocket
//
//  Created by Macsed on 2019/10/13.
//  Copyright © 2019 Macsed. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
class DetailView:UIViewController,UIScrollViewDelegate{
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
       
        let title = UIImageView(image: UIImage(named: "memo2")?.reSetSize(Size: CGSize(width: 125/375*width, height: 19/812*height)))
        title.frame = CGRect(x: 124/375*width, y: 56/812*height, width: 125/375*width, height: 19/812*height)
        let backimg = UIImage(named: "memo3")?.reSetSize(Size: CGSize(width: 13/375*width, height: 20/812*height))
        let backbtn = UIButton(frame: CGRect(x: 20/375*width, y: 57/812*height, width: 13/375*width, height: 20/812*height))
        backbtn.setImage(backimg, for: .normal)
        backbtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(title)
        self.view.addSubview(backbtn)
        self.view.backgroundColor = UIColor(red: 237, green: 239, blue: 244, alpha: 1)
        
        let rollView = UIScrollView(frame: CGRect(x: 0, y: 102/812*height, width: width, height: 710/812*height))
        rollView.contentSize = CGSize(width: width, height: 957/812*height)
        rollView.isScrollEnabled = true
        let textsection = UIImageView(image: UIImage(named: "memo4")?.reSetSize(Size: CGSize(width: width, height: 293/812*height)))
        textsection.frame = CGRect(x: 0, y: 0, width: width, height: 293/812*height)
        rollView.addSubview(textsection)
       rollView.backgroundColor =  UIColor(red: 237, green: 239, blue: 244, alpha: 1)
        
        
        let voicesection = UIView(frame: CGRect(x: 0, y: 293/812*height, width: width, height: 143/812*height))
        let voicetext = UIImageView(image: UIImage(named: "memo5")?.reSetSize(Size: CGSize(width: 31/375*width, height: 15/812*height)))
        voicetext.frame = CGRect(x: 38/375*width, y: 14/812*height, width: 31/375*width, height: 15/812*height)
        let head = UIImageView(image: UIImage(named: "memo6")?.reSetSize(Size: CGSize(width: 57/375*width, height: 57/812*height)))
        head.frame = CGRect(x: 26/375*width, y: 44/812*height, width: 57/375*width, height: 57/812*height)
        let voiceRect = UIImageView(image: UIImage(named: "memo7")?.reSetSize(Size: CGSize(width: 228/375*width, height: 73/812*height)))
        voiceRect.frame = CGRect(x: 79/375*width, y: 36/812*height, width: 228/375*width, height: 73/812*height)
        let voicebtn = UIButton(frame: CGRect(x: 30/375*width, y: 24/812*height, width: 21/375*width, height: 21/812*height))
        voicebtn.setImage(UIImage(named: "memo8")?.reSetSize(Size: CGSize(width: 21/375*width, height: 21/812*height)), for: .normal)
        voiceRect.addSubview(voicebtn)
//
        let voicetime = UIImageView(image: UIImage(named: "memo9")?.reSetSize(Size: CGSize(width: 25/375*width, height: 12/812*height)))
        voicetime.frame = CGRect(x: 176/375*width, y: 29/812*height, width: 25/375*width, height: 12/812*height)
        voiceRect.addSubview(voicetime)

        let voicetotext = UIButton(frame: CGRect(x: 297/375*width, y: 64/812*height, width: 52/375*width, height: 12/812*height))
        voicetotext.setImage(UIImage(named: "memo10")?.reSetSize(Size: CGSize(width: 52/375*width, height: 12/812*height)), for: .normal)
        voicesection.addSubview(voiceRect)
        voicesection.addSubview(head)
        voicesection.addSubview(voicetext)
        voicesection.addSubview(voicetotext)
        rollView.addSubview(voicesection)

        
        
        
        
        
        let photosection = UIImageView(image: UIImage(named: "memo12")?.reSetSize(Size: CGSize(width: width, height: 249/812*height)))
        photosection.frame = CGRect(x: 0, y: 436/812*height, width: width, height: 249/812*height)
        let phototext = UIImageView(image: UIImage(named: "memo11")?.reSetSize(Size: CGSize(width: 30/375*width, height: 15/812*height)))
        phototext.frame = CGRect(x: 39/375*width, y: 10/812*height, width: 30/375*width, height: 15/812*height)
        photosection.addSubview(phototext)
        rollView.addSubview(photosection)
        
        
        
        let videoView = UIView(frame: CGRect(x: 0, y: 681/812*height, width: width, height: 272/812*height))
        let videosection = UIImageView(image: UIImage(named: "img")?.reSetSize(Size: CGSize(width: 339/375*width, height: 191/812*height)))
        videosection.frame = CGRect(x:19/375*width, y: 38/812*height, width:339/375*width, height: 191/812*height)
        let videotext = UIImageView(image: UIImage(named: "memo13")?.reSetSize(Size: CGSize(width: 32/375*width, height: 15/812*height)))
        videotext.frame = CGRect(x: 38/375*width, y: 11/812*height, width: 32/375*width, height: 15/812*height)
        let play = UIButton(frame: CGRect(x: 123/375*width, y: 72/812*height, width: 97/375*width, height: 66/812*height))
        play.setImage(UIImage(named: "memo16")?.reSetSize(Size: CGSize(width: 97/375*width, height: 66/812*height)), for: .normal)
        play.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        videosection.isUserInteractionEnabled = true
        videosection.addSubview(play)
        videoView.addSubview(videosection)
        videoView.addSubview(videotext)
        rollView.addSubview(videoView)
        self.view.addSubview(rollView)
    }
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
//        self.navigationController?.viewControllers[ self.navigationController?.viewControllers]
    }
    @objc func playVideo(){
        let file = Bundle.main.path(forResource: "1", ofType: "mov")
        let videoURL = URL(fileURLWithPath: file!)
        let player = AVPlayer(url: videoURL)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.present(playerVC, animated: true, completion: {
            playerVC.player?.play()
            })
    }
}

