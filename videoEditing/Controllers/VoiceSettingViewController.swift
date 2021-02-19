//  VoiceSettingViewController.swift
//  videoEditing
//  Created by macbook on 7/28/20.
//  Copyright © 2020 macbook. All rights reserved.

import UIKit
import AVFoundation
import MobileCoreServices
import CoreMedia
import AssetsLibrary
import Photos
import MediaPlayer
import AVKit
import StoreKit
import SVProgressHUD



protocol MuteDelegate {
    
    func Mute(Url:AVAssetExportSession)
    
    
}

protocol AddSoundDelegate {
    func AddSound(Asset:AVAssetExportSession)
}



class VoiceSettingViewController: UIViewController, UIGestureRecognizerDelegate, MPMediaPickerControllerDelegate {
    var isSound:Int = 0
    var audioAsset: AVAsset?
    var urlVideo:NSURL?
    var urlout:URL?
    
    var Delegate:MuteDelegate?
    var DelegateSound:AddSoundDelegate?

    @IBOutlet weak var VIEWS: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func DoneButton(_ sender: Any) {
    @IBAction func DoneAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func Mute(_ sender: Any) {
        
        var Url:NSURL?
        if let urlV = UserDefaults.standard.value(forKey: "videoo") as? NSData {
            self.urlVideo = NSKeyedUnarchiver.unarchiveObject(with: urlV as Data) as! NSURL
            Url = NSKeyedUnarchiver.unarchiveObject(with: urlV as Data) as! NSURL
        }
        removeAudioFromVideo( Url as! URL)
//        let assetsLib = ALAssetsLibrary()
//        assetsLib.writeVideoAtPath(toSavedPhotosAlbum: Url as! URL, completionBlock: nil)
        self.dismiss(animated: true, completion: nil)
        
        
     
        
    }

        @IBAction func addSound(_ sender: Any) {
            
        let mediaPickerController = MPMediaPickerController(mediaTypes: .any)
        mediaPickerController.delegate = self
        mediaPickerController.prompt = "Select Audio"
            
        present(mediaPickerController, animated: true, completion: nil)
            
                
    }
    
    
    var mutableVideoURL = NSURL() //final video url
    func removeAudioFromVideo(_ videoURL: URL) {
            let inputVideoURL: URL = videoURL
            let sourceAsset = AVURLAsset(url: inputVideoURL)
        let sourceVideoTrack: AVAssetTrack? = sourceAsset.tracks(withMediaType: AVMediaType.video)[0]
            let composition : AVMutableComposition = AVMutableComposition()
        let compositionVideoTrack: AVMutableCompositionTrack? = composition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let x: CMTimeRange = CMTimeRangeMake(start: CMTime.zero, duration: sourceAsset.duration)
        _ = try? compositionVideoTrack!.insertTimeRange(x, of: sourceVideoTrack!, at: CMTime.zero)
            mutableVideoURL = NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/FinalVideo.mp4")
            let exporter: AVAssetExportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
        exporter.outputFileType = AVFileType.mp4
            exporter.outputURL = mutableVideoURL as URL
        print(exporter.outputURL)
            removeFileAtURLIfExists(url: mutableVideoURL)
            exporter.exportAsynchronously(completionHandler:
                                            
                {
//                    exporter.outputURL = self.urlout

                    switch exporter.status
                    {
                        case AVAssetExportSessionStatus.failed:
                            print("failed \(exporter.error)")
                        case AVAssetExportSessionStatus.cancelled:
                            print("cancelled \(exporter.error)")
                        case AVAssetExportSessionStatus.unknown:
                            print("unknown\(exporter.error)")
                        case AVAssetExportSessionStatus.waiting:
                            print("waiting\(exporter.error)")
                        case AVAssetExportSessionStatus.exporting:
                            print("exporting\(exporter.error)")
                        default:
                            let assetsLib = ALAssetsLibrary()
                            assetsLib.writeVideoAtPath(toSavedPhotosAlbum: exporter.outputURL as! URL, completionBlock: nil)
//                            self.Delegate?.Mute(Url: exporter.outputURL! as NSURL)
                            self.Delegate?.Mute(Url: exporter)

                        
                            print("-----Mutable video exportation complete.")
                    }
                })
        }

        func removeFileAtURLIfExists(url: NSURL) {
            if let filePath = url.path {
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: filePath) {
                    do{
                        try fileManager.removeItem(atPath: filePath)
                         urlout = URL(fileURLWithPath: filePath)
                      
                    } catch let error as NSError {
                        print("Couldn't remove existing destination file: \(error)")
                    }
                }
            }
        }
    
    
    func mediaPicker( _ mediaPicker: MPMediaPickerController,didPickMediaItems mediaItemCollection: MPMediaItemCollection
    ) {
      // 1
      dismiss(animated: true) {
        // 2
        self.isSound = 1
        let selectedSongs = mediaItemCollection.items
        guard let song = selectedSongs.first else { return }
        SVProgressHUD.show(withStatus: "Loading...")

        // 3
        let title: String
        let message: String
        if let url = song.value(forProperty: MPMediaItemPropertyAssetURL) as? URL {
            print(url)
          self.audioAsset = AVAsset(url: url)
           let audioUrl = UserDefaults.standard.set(url, forKey: "AudioUrl")
            print(audioUrl)
          title = "Asset Loaded"
          message = "Audio Loaded"
        } else {
          self.audioAsset = nil
          title = "Asset Not Available"
          message = "Audio Not Loaded"
        }
        // 4
        SVProgressHUD.dismiss {
            let alert = UIAlertController(title: title,  message: message,  preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

      
        
        if let urlV = UserDefaults.standard.value(forKey: "videoo") as? NSData {
            self.urlVideo = NSKeyedUnarchiver.unarchiveObject(with: urlV as Data) as! NSURL
        }
        if let audioU = UserDefaults.standard.url(forKey: "AudioUrl"){
            print(self.urlVideo)
            print(UserDefaults.standard.object(forKey: "Audio Url") as? NSURL? )
            self.mergeFilesWithUrl( videoUrl: self.urlVideo!, audioUrl:audioU as NSURL)
        }
     
      }
    }

    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
      // 5
      dismiss(animated: true, completion: nil)
    }
    
    
//
//    func savedPhotosAvailable() -> Bool {
//      guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
//        else { return true }
//
//      let alert = UIAlertController(
//        title: "Not Available",
//        message: "No Saved Album found",
//        preferredStyle: .alert)
//      alert.addAction(UIAlertAction(
//        title: "OK",
//        style: UIAlertAction.Style.cancel,
//        handler: nil))
//      present(alert, animated: true, completion: nil)
//      return false
//    }
    
    func mergeFilesWithUrl(videoUrl:NSURL, audioUrl:NSURL)
    {
        
        let mixComposition : AVMutableComposition = AVMutableComposition()
        var mutableCompositionVideoTrack : [AVMutableCompositionTrack] = []
        var mutableCompositionAudioTrack : [AVMutableCompositionTrack] = []
        let totalVideoCompositionInstruction : AVMutableVideoCompositionInstruction = AVMutableVideoCompositionInstruction()
        
        
        //start merge
        
        let aVideoAsset : AVAsset = AVAsset(url: videoUrl as URL)
        let aAudioAsset : AVAsset = AVAsset(url: audioUrl as URL)
        
        mutableCompositionVideoTrack.append(mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)!)
        mutableCompositionAudioTrack.append( mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!)
        
        let aVideoAssetTrack : AVAssetTrack = aVideoAsset.tracks(withMediaType: AVMediaType.video)[0]
        let aAudioAssetTrack : AVAssetTrack = aAudioAsset.tracks(withMediaType: AVMediaType.audio)[0]
        
        
        
        do{
            try mutableCompositionVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aVideoAssetTrack.timeRange.duration), of: aVideoAssetTrack, at: CMTime.zero)
            
            //In my case my audio file is longer then video file so i took videoAsset duration
            //instead of audioAsset duration
            
            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aVideoAssetTrack.timeRange.duration), of: aAudioAssetTrack, at: CMTime.zero)
            
            //Use this instead above line if your audiofile and video file's playing durations are same
//
//            try mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aAudioAssetTrack.timeRange.duration), of: aAudioAssetTrack, at: kCMTimeZero)
            
        }catch{
            
        }
        
        totalVideoCompositionInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero,duration: aVideoAssetTrack.timeRange.duration )
        
        let mutableVideoComposition : AVMutableVideoComposition = AVMutableVideoComposition()
        mutableVideoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        
        mutableVideoComposition.renderSize = CGSize(width: 1280, height: 720)
        

        
        //        playerItem = AVPlayerItem(asset: mixComposition)
        //        player = AVPlayer(playerItem: playerItem!)
        //
        //
        //        AVPlayerVC.player = player
        
        //find your video on this URl
        let savePathUrl : NSURL = NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/newVideo.mp4")
        do { // delete old video
            try FileManager.default.removeItem(at: savePathUrl as URL)
            } catch { print(error.localizedDescription) }
        
        let assetExport: AVAssetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)!
        
        assetExport.outputFileType = AVFileType.mp4
        assetExport.outputURL = savePathUrl as URL
        
        print(savePathUrl)
        
        
        SVProgressHUD.show(withStatus: "Loading...")

        assetExport.shouldOptimizeForNetworkUse = true
//        UserDefaults.standard.set(savePathUrl, forKey: "pathUrl")
        
        
        let videoos=UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: savePathUrl), forKey: "pathUrl")
        print(videoos)

        
        
        
        

        assetExport.exportAsynchronously { () -> Void in
            switch assetExport.status {
                
            case AVAssetExportSessionStatus.completed:
                
                //Uncomment this if u want to store your video in asset
                
                let assetsLib = ALAssetsLibrary()
//    
//                assetsLib.writeVideoAtPath(toSavedPhotosAlbum: savePathUrl as URL, completionBlock: nil)
                
                
                
                
                SVProgressHUD.dismiss {

                    self.dismiss(animated: true) {
                        
                        self.DelegateSound?.AddSound(Asset: assetExport)

                    }
                }

                print("success")
//                DispatchQueue.main.async {
//                  self.exportDidFinish(assetExport)
//                }
             case  AVAssetExportSessionStatus.failed:
                print("failed \(assetExport.error)")
            case AVAssetExportSessionStatus.cancelled:
                print("cancelled \(assetExport.error)")
            default:
                print("complete")
            }
        }
        
      

    }
    


    
    
    
    
    
}
