//
//  VideoTableViewCell.swift
//  videoEditing
//
//  Created by macbook on 12/19/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SVProgressHUD

protocol ShareDelegate {
    func share(display:NSURL)
}
class VideoTableViewCell: UITableViewCell {
    
    static var identifier = "VideoTableViewCell"
    var shareDelegate: ShareDelegate?
    
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var videoPlayer: UIView!
    var isPlaying:Bool = false
    @IBOutlet weak var num: UILabel!
    
    var playerViewController: AVPlayerViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var _display:NSURL = NSURL()
    
    @IBAction func send(_ sender: Any) {
        
        if let _delegate = shareDelegate {
            _delegate.share(display: _display)
        }

    }
    
    @IBAction func playBtn(_ sender: Any) {
        if !isPlaying{
            playerViewController.player?.play()
            playButton.alpha = 0.2
            
            
        }else{
            playerViewController.player?.pause()
            playButton.alpha = 1.0
        }
        isPlaying = !isPlaying
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(display:NSURL){
        print(display)
        _display = display
        
        let asset2 = AVAsset(url: _display as URL)
        let playerItem = AVPlayerItem(asset: asset2)
        let player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

        playerViewController = AVPlayerViewController()
        playerViewController.videoGravity=AVLayerVideoGravity.resizeAspectFill
        playerViewController.player = player
        playerViewController.player?.seek(to: .init(seconds: 1.0, preferredTimescale: 600))
        //gets the frame size of table view cell view
        playerViewController.view.frame = videoPlayer.frame
//            CGRect (x:0, y:0, width:videoPlayer.frame.size.width, height:videoPlayer.frame.size.height)
//
        //                    playerViewController.player?.play()
        
        videoPlayer.addSubview(playerViewController.view)
        //            playerViewController.didMove(toParent: self)
        
    }
    
}

