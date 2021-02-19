//
//  VideoTableViewController.swift
//  videoEditing
//
//  Created by macbook on 12/19/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Foundation

protocol urlSharingDelegate {
    
    func  url(video:[NSURL])
    
}

class VideoTableViewController: UIViewController {
    var urlVideos:[NSURL]=[]
    
    var playerLayer: AVPlayerLayer!
    let playerViewController = AVPlayerViewController()
    var asset2: AVAsset!
    var index=0
    @IBOutlet var videoTable: UITableView!
    let vc:CutterViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        videoTable.delegate = self
        videoTable.dataSource = self
        
    }
    
    @IBAction func shareAllBtn(_ sender: Any) {
        //        guard let image = UIImage(named: "img") else { return }
        var activityController = UIActivityViewController(activityItems: [urlVideos], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        self.present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
        
//        present(activityController, animated: true) {
//            print("presented")
//        }
        
    }
    // MARK: - Table view data source
    
    func registerNib(){
        let nib = UINib(nibName: "VideoTableViewCell", bundle: nil)
        videoTable.register(nib, forCellReuseIdentifier: "VideoTableViewCell")
    }
}
extension VideoTableViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlVideos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.num.text="\(indexPath.row+1)"
        cell.configure(display: urlVideos[indexPath.row])
        cell.shareDelegate = self
        print(urlVideos[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(urlVideos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        guard let videoCell = (cell as? VideoTableViewCell) else { return };
        let visibleCells = videoTable.visibleCells;
        let minIndex = visibleCells.startIndex;
        if videoTable.visibleCells.index(of: cell) == minIndex {
            videoCell.playerViewController.player?.play()
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let videoCell = cell as? VideoTableViewCell else { return };
        videoCell.playerViewController.player?.pause();
        videoCell.playerViewController.player = nil;
    }
}
          
//    func shareToInstagramStories(image: UIImage) {
//        // NOTE: you need a different custom URL scheme for Stories, instagram-stories, add it to your Info.plist!
//        guard let instagramUrl = URL(string: "instagram-stories://share") else {
//            return
//        }
//        if UIApplication.shared.canOpenURL(instagramUrl) {
//            let pasterboardItems = [["com.instagram.sharedSticker.backgroundImage": image as Any]]
//            UIPasteboard.general.setItems(pasterboardItems)
//            UIApplication.shared.open(instagramUrl)
//        } else {
//            // Instagram app is not installed or can't be opened, pop up an alert
//        }
//    }

extension VideoTableViewController:urlSharingDelegate{
    func url(video: [NSURL]) {
        print(video)
        urlVideos = video
    }
}
extension VideoTableViewController:ShareDelegate{
    func share(display: NSURL) {
        let activityController = UIActivityViewController(activityItems: [display], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        self.present(activityController, animated: true, completion: nil)
    }
}

