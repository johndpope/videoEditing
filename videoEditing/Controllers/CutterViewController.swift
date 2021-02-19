//  CutterViewController.swift
//  videoEditing
//  Created by macbook on 7/22/20.
//  Copyright © 2020 macbook. All rights reserved.

import UIKit
import AVFoundation
import MobileCoreServices
import CoreMedia
import AssetsLibrary
import Photos
import MOLH
import Localize_Swift
import SVProgressHUD


class CutterViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let delegateVideo :urlSharingDelegate? = nil
    var isSound:Int = 0
    var loop:Int = 0
    var numberUrl :[Int]=[]
    var videoTrimming:[NSURL] = []
    var startTimestr = ""
    var endTimestr = ""
    var isPlaying = true
    var mediaAspectRatio: Double!
    var playbackTimeCheckerTimer: Timer! = nil
    let playerObserver: Any? = nil
    let exportSession: AVAssetExportSession! = nil
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var playerLayer: AVPlayerLayer!
    var startTime: CGFloat = 0.0
    var stopTime: CGFloat  = 0.0
    var thumbTime: CMTime!
    var thumbtimeSeconds: Int!
    var videoPlaybackPosition: CGFloat = 0.0
    var cache:NSCache<AnyObject, AnyObject>!
    var videoPicker: VideoPicker!
    var asset: AVAsset!
    var asset2: AVAsset!
    var url:NSURL! = nil
    var urlSharing:[NSURL]=[]
    var objects:MainCategory?
    
    var vc:CutterViewController!
    
    private var cutterSecond: Int = 10
    
    enum size{
        
        case tube
        case feed
        case storyInsta
        case storyAlls
        
    }
    
    
    var type:size?{
        didSet{
            
        }
    }
    var cutterSeconds: Int {
        set{
            cutterSecond =  newValue
        }
        get {
            return cutterSecond
        }
    }
    var widthView:CGFloat = 0.0
    var heightView:CGFloat = 0.0
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    
    
    var sec:[Int]=[10,15,20,25,30,60]
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var DurationOutlet: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeOutlet: UILabel!
    @IBOutlet weak var secTime: UILabel!
    
    @IBOutlet weak var numOfVideo: UILabel!
    
    @IBOutlet weak var addVideo: UIButton!
    @IBOutlet weak var views: UIView!
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var btnFeed: UIButton!
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var imgFeed: UIImageView!
    @IBOutlet weak var ratioFeed: UILabel!
    
    @IBOutlet weak var btnStory2: UIButton!
    @IBOutlet weak var story2Label: UILabel!
    @IBOutlet weak var img2Label: UIImageView!
    @IBOutlet weak var ratioStory2: UILabel!
    
    
    @IBOutlet weak var btnTube: UIButton!
    @IBOutlet weak var tubeLabel: UILabel!
    @IBOutlet weak var imgTube: UIImageView!
    @IBOutlet weak var ratioTube: UILabel!
    
    
    @IBOutlet weak var btnStory1: UIButton!
    @IBOutlet weak var story1: UILabel!
    @IBOutlet weak var imgStory1: UIImageView!
    @IBOutlet weak var ratioStory1: UILabel!
    
    
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    
    @IBOutlet weak var plusBtn: UIView!
    @IBOutlet weak var secondBtn: UIView!
    
    @IBOutlet weak var deleteVideo: UIButton!
    
    var pathU:URL?
    
    @IBOutlet weak var done: UIButton!
    
    @IBAction func DoneAction(_ sender: Any) {
        //
        if (done.backgroundColor == UIColor(named: "Color2")){
            navigationController?.popToRootViewController(animated: true)
        }else if(done.backgroundColor == UIColor(named: "Color3")){
          
            //        if (done.titleLabel?.text == "Go to Home"){
            //            navigationController?.popViewController(animated: true)
            //        }else{
            ////        if let urlV = UserDefaults.standard.value(forKey: "pathUrl") as? NSData {
            ////
            ////            self.pathU = NSKeyedUnarchiver.unarchiveObject(with: urlV as Data) as! URL
            ////            print(pathU)
            ////        }
            //
            switch self.type {
            case .tube:
                do {
                    
                    cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[5]))
                    
                                    }
                break
                
            case .feed:
                do {
                    if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[1] {
                        cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[1]))
                    }else{
                        cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[0]))
                    }
                }
                break
            case .storyInsta:
                do {
                    if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[1] {
                        cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[1]))
                    }else{
                        cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[0]))
                    }
                }
                break
            case .storyAlls:
                do {
                    if (self.objects == MainCategory.messenger){
                        do {
                            if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[2] {
                                cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[2]))
                            }else{
                                cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[0]))
                            }
                        }
                    }
                    else if (self.objects == MainCategory.whatsapp){
                        do {
                            if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[4] {
                                cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[4]))
                            }else{
                                cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[0]))
                                
                            }
                            
                        }
                    }
                    else if (self.objects == MainCategory.tikTok){
                        do {
                            if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[5] {
                                cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[5]))
                            }else{
                                cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[0]))
                            }
                        }
                    }
                    else if (self.objects == MainCategory.snapShat){
                        do {
                            
                            cropVideoRange(urls:vc.url , startValue: Float(0), endValue: Float(sec[0]))
                            
                            //                        sharing()
                        }
                    }
                }
                
            case .none:
                print("error")
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        done.setTitle("Go to Home", for: .normal)
        Style()
        print(UserDefaults.standard.set(nil, forKey: "thumbtimeSeconds"))
        screenWidth = videoView.bounds.width - 20
        screenHeight = videoView.bounds.height - 20
        setUp2()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        initialize()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        playeer()
        
        
    }
    
    @IBAction func deleteVideo(_ sender: Any) {
        let asyncGroup = DispatchGroup()
        asyncGroup.enter()
        player!.pause()
        player = nil
        self.playerLayer?.player = nil
        self.playerLayer?.frame=CGRect()
      
        asyncGroup.leave()
        
        asyncGroup.notify(queue: DispatchQueue.main) {
            self.addVideo.isHidden = false
            self.thumbtimeSeconds=nil
            self.numOfVideo.text = "\(0)"
            self.vc.url = nil
            self.DurationOutlet.text="0:00"
            self.sizeOutlet.text="0"
            self.done.backgroundColor = UIColor(named: "Color2")
            self.done.setTitle("Go to Home", for: .normal)
        }
    
    }
    
    
    public func initialize(){
        removeNavigationBarBorder()
        navigationItem.title = ""
        let regularBarButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "color8"),
            .font: UIFont(name: "MarkerFelt-Thin", size: 16)!
        ]
        navigationController?.navigationBar.tintColor = UIColor(named: "color8")
    }
    
    func Style() {
        
        if lang() == "ar"{
            plusBtn.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 28)
            
            
            secondBtn.roundCorners([.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: 28)
            
            
        }else{
            plusBtn.roundCorners([.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: 28)
            
            secondBtn.roundCorners([.layerMaxXMinYCorner,.layerMaxXMaxYCorner], radius: 28)
            
        }
    }
    
    @IBAction func videoPickerButtonTouched(_ sender: UIButton) {
        let myImagePickerController        = UIImagePickerController()
        myImagePickerController.sourceType = .photoLibrary
        myImagePickerController.mediaTypes = [(kUTTypeMovie) as String]
        myImagePickerController.delegate   = self
        myImagePickerController.isEditing  = false
        self.present(myImagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        done.backgroundColor = UIColor(named: "Color3")
        picker.dismiss(animated: true, completion: nil)
        let url = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
        let asset   = AVURLAsset.init(url: url! as URL)
        done.setTitle("Done", for: .normal)
        let mainstoryBoard = UIStoryboard(name:"Main", bundle: nil)
        vc = mainstoryBoard.instantiateViewController(withIdentifier:"CutterViewController") as? CutterViewController
        vc.url = url
        UserDefaults.standard.set(vc.url as URL, forKey: "urlVideo")
        addVideo.isHidden = true
        vc.asset=asset
        asset2=vc.asset
        //        self.navigationController?.pushViewController(vc, animated: true)
        player = AVPlayer()
        self.cache = NSCache()
        playeer()
        
    }
    
    func initAspectRatioOfVideo(with fileURL: URL) {
        let resolution = resolutionForLocalVideo(url: fileURL)
        playerLayer.needsDisplayOnBoundsChange = true
    }
    
    private func resolutionForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        
        widthView = size.width
        heightView = size.height
        print(heightView)
        print(widthView)
        
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
    public func setUp2(){
        self.type = .feed
        
        if (objects != nil) {
            if objects==MainCategory.snapShat{
                imageView.image = UIImage.init(named: "snapchat (1)")
                secTime.text="\(stringFromTimeInterval(interval:sec[0] ))"
                cutterSeconds = sec[0]
                story1On()
                feedOff()
                story2Off()
                tubeOff()
                self.type = .storyAlls
                
            }else if objects==MainCategory.whatsapp{
                imageView.image = UIImage.init(named: "whatsapp2")
                secTime.text="\(stringFromTimeInterval(interval:sec[4] ))"
                cutterSeconds = sec[4]
                
                story1On()
                feedOff()
                story2Off()
                tubeOff()
                self.type = .storyAlls
                
            }else if objects==MainCategory.messenger{
                imageView.image = UIImage.init(named: "messanger2")
                secTime.text="\(stringFromTimeInterval(interval:sec[2] ))"
                self.type = .storyAlls
                cutterSeconds = sec[2]
                
                story1On()
                feedOff()
                story2Off()
                tubeOff()
                self.type = .storyAlls
                
            }else if objects==MainCategory.instagram{
                
                imageView.image = UIImage.init(named: "instagram2")
                secTime.text="\(stringFromTimeInterval(interval:sec[1] ))"
                cutterSeconds = sec[1]
                
                Story2On()
                feedOff()
                story1Off()
                tubeOff()
                
                self.type = .storyInsta
            }else if objects==MainCategory.youTube{
                imageView.image = UIImage.init(named: "tube")
                secTime.text="\(stringFromTimeInterval(interval:sec[5] ))s"
                cutterSeconds = sec[5]
                tubeOn()
                feedOff()
                story2Off()
                story1Off()
                self.type = .tube
                
            }else if objects==MainCategory.tikTok{
                imageView.image = UIImage.init(named: "tiktok2")
                secTime.text="\(stringFromTimeInterval(interval:sec[5] ))s"
                cutterSeconds = sec[5]
                
                story1On()
                feedOff()
                story2Off()
                tubeOff()
                self.type = .storyAlls
              
            }
        }
    }
    
    @IBAction func feedAction(_ sender: Any) {
        if  self.playerLayer?.frame != nil {
            if self.vc.url != nil{
                
                feedOn()
                story2Off()
                tubeOff()
                story1Off()
                self.type = .feed
                selectType()
                if thumbtimeSeconds != nil{
                    var noLoop=thumbtimeSeconds/sec[1]
                    numberOfVideo(value: sec[1])
                    secTime.text="\(stringFromTimeInterval(interval:sec[1] ))s"

                }
            }else{
                let alert = UIAlertController(title: "videoEditing", message:
                                                "You should first Choosing the video from (+) ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "videoEditing", message:
                                            "You should first Choosing the video from (+) ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    @IBAction func story2(_ sender: Any) {
        if  self.playerLayer?.frame != nil {
            if self.vc.url != nil{
                
                Story2On()
                feedOff()
                tubeOff()
                story1Off()
                self.type = .storyInsta
                selectType()
                secTime.text="\(stringFromTimeInterval(interval:sec[1] ))s"

                if thumbtimeSeconds != nil{
                    var noLoop=thumbtimeSeconds/sec[1]
                    numberOfVideo(value: sec[1])
                    
                    
                }
            }else{
                let alert = UIAlertController(title: "videoEditing", message:
                                                "You should first Choosing the video from (+) ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alert, animated: true, completion: nil)
                
            }
        }else{
            let alert = UIAlertController(title: "videoEditing", message:
                                            "You should first Choosing the video from (+) ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func tubeAction(_ sender: Any) {
        if  self.playerLayer?.frame != nil {
            if vc.url != nil{
                btnTube.isEnabled=true
                
                tubeOn()
                feedOff()
                story2Off()
                story1Off()
                self.type = .tube
                secTime.text="\(stringFromTimeInterval(interval:sec[5] ))s"

                selectType()
                if thumbtimeSeconds != nil{
                    numberOfVideo(value: sec[5])
                }
            }else{
                let alert = UIAlertController(title: "videoEditing", message:
                                                "You should first Choosing the video from (+) ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "videoEditing", message:
                                            "You should first Choosing the video from (+) ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func story1Action(_ sender: Any) {
        if  self.playerLayer?.frame != nil {
            if self.vc.url != nil{
                
                btnStory1.isEnabled=true
                
                story1On()
                feedOff()
                story2Off()
                tubeOff()
                self.type = .storyAlls
                selectType()

                if thumbtimeSeconds != nil{
                    do {
                        if (self.objects == MainCategory.messenger){
                            numberOfVideo(value: sec[2])
                            secTime.text="\(stringFromTimeInterval(interval:sec[2] ))s"

                        }
                        else if (self.objects == MainCategory.whatsapp){
                            numberOfVideo(value: sec[4])
                            secTime.text="\(stringFromTimeInterval(interval:sec[4] ))s"

                        }
                        else if (self.objects == MainCategory.tikTok){
                            numberOfVideo(value: sec[5])
                            secTime.text="\(stringFromTimeInterval(interval:sec[5] ))s"

                        }
                        else if (self.objects == MainCategory.snapShat){
                            numberOfVideo(value: sec[0])
                            secTime.text="\(stringFromTimeInterval(interval:sec[0] ))s"

                        }
                    }
                }
            }else{
                let alert = UIAlertController(title: "videoEditing", message:
                                                "You should first Choosing the video from (+) ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "videoEditing", message:
                                            "You should first Choosing the video from (+) ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func plusAction(_ sender: Any) {
        print(cutterSeconds)
        print(UserDefaults.standard.integer(forKey: "thumbtimeSeconds"))
        if cutterSeconds>=10 && cutterSeconds<3600{
            if  cutterSeconds < UserDefaults.standard.integer(forKey: "thumbtimeSeconds"){
                cutterSeconds+=5
                plusFunction()
                secTime.text="\(stringFromTimeInterval(interval: cutterSeconds) as String)"
                numberOfVideo(value: cutterSeconds)
            }else{
                if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") != 0{
                    let alertController = UIAlertController(title: "videoEditing", message:
                                                                "The cutting period  should be less than video duration", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                    addVideo.isHidden=false
                }else{
                    cutterSeconds+=5
                    plusFunction()
                    secTime.text="\(stringFromTimeInterval(interval: cutterSeconds) as String)"
                }
            }
        }else{
            plus.isEnabled = false
        }
    }
    @IBAction func minusAction(_ sender: Any) {
        print(cutterSeconds)
        if cutterSeconds>=15 {
            cutterSeconds-=5
            
            plusFunction()
            print(cutterSeconds)
            secTime.text="\(stringFromTimeInterval(interval: cutterSeconds) as String)"
            
        }else{
            minus.isEnabled = false
        }
    }
    
    
    
    @IBAction func popBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VoiceSettingViewController") as? VoiceSettingViewController
        print(isSound)
        //        if (vc?.isSound==0){
        vc?.Delegate = self
        
        //        }else{
        vc?.DelegateSound = self
        
        //        }
        
        self.present(vc!, animated: true, completion: nil)
    }
    
    
}
extension CutterViewController{
    public func feedOn(){
        imgFeed.image=UIImage.init(named: "lineON")
        feedLabel.textColor = UIColor.white
        ratioFeed.textColor = UIColor.white
        self.type = .feed
        
    }
    public func feedOff(){
        
        imgFeed.image=UIImage.init(named: "lineOFF")
        feedLabel.textColor = UIColor(named: "Color4")
        ratioFeed.textColor = UIColor(named: "Color4")
        
    }
    public func Story2On(){
        img2Label.image=UIImage.init(named: "lineON")
        story2Label.textColor = UIColor.white
        ratioStory2.textColor = UIColor.white
        self.type = .storyAlls
        
    }
    
    public func story2Off(){
        img2Label.image=UIImage.init(named: "lineOFF")
        story2Label.textColor = UIColor(named: "Color4")
        ratioStory2.textColor = UIColor(named: "Color4")
  
    }
    public func tubeOn(){
        imgTube.image=UIImage.init(named: "lineON")
        tubeLabel.textColor = UIColor.white
        ratioTube.textColor = UIColor.white
        self.type = .tube
    }
    public func tubeOff(){
        imgTube.image=UIImage.init(named: "lineOFF")
        tubeLabel.textColor = UIColor(named: "Color4")
        ratioTube.textColor = UIColor(named: "Color4")
    }
    public func story1On(){
        imgStory1.image=UIImage.init(named: "lineON")
        story1.textColor = UIColor.white
        ratioStory1.textColor = UIColor.white
        self.type = .storyInsta
    }
    public func story1Off(){
        imgStory1.image=UIImage.init(named: "lineOFF")
        story1.textColor = UIColor(named: "Color4")
        ratioStory1.textColor = UIColor(named: "Color4")
    }
    
}
extension CutterViewController{
    
    public func plusFunction(){
        switch cutterSecond {
        case 10:
            imageView.image = UIImage.init(named: "snapchat (1)")
            animateOfView()
            story1On()
            feedOff()
            story2Off()
            tubeOff()
            self.type = .storyAlls
            
        case 15:
            imageView.image = UIImage.init(named: "instagram2")
            animateOfView()
            Story2On()
            feedOff()
            tubeOff()
            story1Off()
            self.type = .storyInsta
        case 20:
            imageView.image = UIImage.init(named: "messanger2")
            animateOfView()
            story1On()
            feedOff()
            story2Off()
            tubeOff()
            self.type = .storyAlls
        case 25:
            imageView.image = UIImage.init(named: "facebook (1)")
            animateOfView()
            story1On()
            feedOff()
            story2Off()
            tubeOff()
            self.type = .storyAlls
        case 30:
            imageView.image = UIImage.init(named: "whatsapp2")
            animateOfView()
            story1On()
            feedOff()
            story2Off()
            tubeOff()
            self.type = .storyAlls
        case 60:
            imageView.image = UIImage.init(named: "tiktok2")
            animateOfView()
            story1On()
            feedOff()
            story2Off()
            tubeOff()
            self.type = .storyAlls
        default:
            imageView.image = UIImage.init(named: "tube")
            animateOfView()
            tubeOn()
            feedOff()
            story2Off()
            story1Off()
            self.type = .tube
        }
    }
}

public func animateOfView(){
    let someView = UIImageView()
    let scaleTransform = CGAffineTransform(scaleX:0.3, y: 0.3)
    someView.transform = scaleTransform
    UIImageView.animate(withDuration: 0.5,animations: {
        someView.transform = CGAffineTransform.identity
    })
}

extension CutterViewController{
    
    public func playeer(){
        
        if let assets = asset2
        
        {
            thumbTime = asset2.duration
            print(thumbTime)
            thumbtimeSeconds = Int((CMTimeGetSeconds(thumbTime)))
            print(thumbtimeSeconds)
            UserDefaults.standard.set(thumbtimeSeconds, forKey: "thumbtimeSeconds")
            do {
                if (self.objects == MainCategory.messenger){
                    if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[2] {
                        numberOfVideo(value: sec[2])
                    }else{
                        numberOfVideo(value: sec[0])
                        
                        let alert = UIAlertController(title: "videoEditing", message:
                                                        "The cutting period  should be less than video duration so the period of duration become 10 sec ".localized(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else if (self.objects == MainCategory.whatsapp){
                    if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[4] {
                        numberOfVideo(value: sec[4])
                    }else{
                        numberOfVideo(value: sec[0])
                        secTime.text="\(stringFromTimeInterval(interval:sec[0] ))s"
                        
                        let alert = UIAlertController(title: "videoEditing", message:
                                                        "The cutting period  should be less than video duration so the period of duration become 10 sec ".localized(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        
                        self.present(alert, animated: true, completion: nil)
                    }                    }
                else if (self.objects == MainCategory.tikTok){
                    if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[5] {
                        numberOfVideo(value: sec[5])
                    }else{
                        numberOfVideo(value: sec[0])
                        secTime.text="\(stringFromTimeInterval(interval:sec[0] ))s"
                        
                        let alert = UIAlertController(title: "videoEditing", message:
                                                        "The cutting period  should be less than video duration so the period of duration become 10 sec ".localized(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        
                        self.present(alert, animated: true, completion: nil)
                    }}
                else if (self.objects == MainCategory.snapShat){
                    if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[0] {
                        numberOfVideo(value: sec[0])
                    }else{
                        numberOfVideo(value: sec[0])
                        secTime.text="\(stringFromTimeInterval(interval:sec[0] ))s"
                        
                        let alert = UIAlertController(title: "videoEditing", message:
                                                        "The cutting period  should be less than video duration so the period of duration become 10 sec ".localized(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        
                        self.present(alert, animated: true, completion: nil)
                    }}
                else if (self.objects == MainCategory.instagram){
                    if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[1] {
                        numberOfVideo(value: sec[1])
                    }else{
                        numberOfVideo(value: sec[0])
                        secTime.text="\(stringFromTimeInterval(interval:sec[0] ))s"
                        
                        let alert = UIAlertController(title: "videoEditing", message:
                                                        "The cutting period  should be less than video duration so the period of duration become 10 sec ".localized(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }   else if (self.objects == MainCategory.youTube){
                    if UserDefaults.standard.integer(forKey: "thumbtimeSeconds") >= sec[5] {
                        numberOfVideo(value: sec[5])
                    }else{
                        numberOfVideo(value: sec[0])
                        secTime.text="\(stringFromTimeInterval(interval:sec[0] ))s"
                        
                        let alert = UIAlertController(title: "videoEditing", message:
                                                        "The cutting period  should be less than video duration so the period of duration become 10 sec ".localized(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        
                        self.present(alert, animated: true, completion: nil)
                    }                    }
            }
            let duration = stringFromTimeInterval(interval: thumbtimeSeconds)
            UserDefaults.standard.set(duration, forKey: "duration")
            DurationOutlet.text=duration as String
            if  thumbTime.seconds>=10{
                self.viewAfterVideoIsPicked()
                let item:AVPlayerItem = AVPlayerItem(asset: self.asset2)
                self.player                = AVPlayer(playerItem: item)
                self.playerLayer           = AVPlayerLayer(player: self.player)
                self.player.actionAtItemEnd   = AVPlayer.ActionAtItemEnd.none
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnvideoPlayerView))
                self.videoView.addGestureRecognizer(tap)
                self.tapOnvideoPlayerView(tap: tap)
                self.videoView.layer.addSublayer(self.playerLayer)
                self.player.pause()
                let assetSizeBytes = self.asset2.tracks(withMediaType: AVMediaType.video).first?.totalSampleDataLength
                let size = Units(bytes: assetSizeBytes ?? 0).getReadableUnit()
                self.sizeOutlet.text = size
                self.initAspectRatioOfVideo(with:vc.url as URL)
                self.resolutionForLocalVideo(url: vc.url as URL)
                print(vc.url!)
                var urlVideo = vc.url
                let videoo: Void=UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: urlVideo), forKey: "videoo")
                if let urlV = UserDefaults.standard.value(forKey: "videoo") as? NSData {
                    urlVideo = NSKeyedUnarchiver.unarchiveObject(with: urlV as Data) as? NSURL
                }
                print(urlVideo)
                if screenHeight>screenWidth{
                    switch self.type {
                    case .tube: setSizeTube()
                    case .feed: setSizeFeed()
                    case .storyInsta:setSizeStoryInstagram()
                    case .storyAlls:setSizestoryAll()
                    case .none:
                        print("error")
                    }
                }
            }else {
                print("CRITICAL: The duration of video should be more than 10 seconds")
                let alertController = UIAlertController(title: "videoEditing", message:
                                                            "The duration of video should be more than 10 seconds", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alertController, animated: true, completion: nil)
                
            }
        }else{
            print("CRITICAL -> ERROR nil")
        }
    }
    
    func stringFromTimeInterval(interval:NSInteger) -> NSString {
        
        let ti = interval
        let ms = ti * 1000
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        if hours == 0{
            return NSString(format: "%0.2d:%0.2d",minutes,seconds,ms)
        }
        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds,ms)
    }
    
    
    func viewAfterVideoIsPicked()
    {
        if(playerLayer != nil)
        {
            playerLayer.removeFromSuperlayer()
        }
        startTimestr = "\(0.0)"
        endTimestr   = "\(thumbtimeSeconds!)"
        
    }
    @objc func tapOnvideoPlayerView(tap: UITapGestureRecognizer)
    {
        if vc.url != nil {
            
            
            if isPlaying
            {
                self.player.play()
                
            }
            else
            {
                self.player.pause()
            }
            
            isPlaying = !isPlaying
            
        }
    }
}

public struct Units {
    
    public let bytes: Int64
    
    public var kilobytes: Double {
        return Double(bytes) / 1_024
    }
    
    public var megabytes: Double {
        return kilobytes / 1_024
    }
    
    public var gigabytes: Double {
        return megabytes / 1_024
    }
    
    public init(bytes: Int64) {
        self.bytes = bytes
    }
    
    public func getReadableUnit() -> String {
        
        switch bytes {
        case 0..<1_024:
            return "\(bytes) bytes"
        case 1_024..<(1_024 * 1_024):
            return "\(String(format: "%.2f", kilobytes)) kb"
        case 1_024..<(1_024 * 1_024 * 1_024):
            return "\(String(format: "%.2f", megabytes)) mb"
        case (1_024 * 1_024 * 1_024)...Int64.max:
            return "\(String(format: "%.2f", gigabytes)) gb"
        default:
            return "\(bytes) bytes"
        }
    }
}
extension CutterViewController{
    
    public func setSizeFeed(){
        
        let w = ((self.videoView.bounds.width-screenWidth)/2)
        let h = ((self.videoView.bounds.height-screenWidth+40)/2)
        self.playerLayer?.frame = CGRect(x: w, y: h, width:screenWidth, height:(screenWidth))
        videoView.frame.size=(playerLayer.frame.size)
        videoView.bounds.size=(playerLayer.bounds.size)
        self.playerLayer?.videoGravity = AVLayerVideoGravity.resize
    }
    
    public func setSizeStoryInstagram(){
        
        let w = ((self.videoView.bounds.width-screenWidth)/2)
        let h = ((self.videoView.bounds.height-(screenWidth*0.8))/2)
        print(screenWidth)
        self.playerLayer?.frame = CGRect(x: w, y: h, width:screenWidth, height: (screenWidth*0.8))
        videoView.frame.size=(playerLayer.frame.size)
        videoView.bounds.size=(playerLayer.bounds.size)
        self.playerLayer.videoGravity = AVLayerVideoGravity.resize
       
    }
    
    public func setSizeTube(){
        
        let w = ((self.videoView.bounds.width-screenWidth)/2)
        let h = ((self.videoView.bounds.height-(screenWidth*0.5625))/2)
        self.playerLayer?.frame = CGRect(x: w, y: h, width:screenWidth, height: (screenWidth*0.5625))
        
        videoView.frame.size=(playerLayer.frame.size)
        videoView.bounds.size=(playerLayer.bounds.size)
        self.playerLayer?.videoGravity = AVLayerVideoGravity.resize
        
    }
    
    public func setSizestoryAll(){
        let w = ((self.videoView.bounds.width-(screenWidth-170))/2)
        let h = ((self.videoView.bounds.height-((screenWidth-200)*1.78))/2)
        self.playerLayer?.frame = CGRect(x: w, y: h, width:(screenWidth-170), height: ((screenWidth-200)*1.78))
        videoView.frame.size=(playerLayer.frame.size)
        videoView.bounds.size=(playerLayer.bounds.size)
        self.playerLayer?.videoGravity = AVLayerVideoGravity.resize
        
    }
    
    public func selectType(){
        
        switch self.type {
        case .feed:setSizeFeed()
        case .storyInsta:setSizeStoryInstagram()
        case .storyAlls:setSizestoryAll()
        case .tube:setSizeTube()
            
        default:
            print("error")
        }
       
    }
    
}
extension CutterViewController{
    
    public func cropVideoRange(urls:NSURL ,startValue:Float ,endValue:Float){
        let durat = UserDefaults.standard.integer(forKey: "thumbtimeSeconds")+1
        
        loop = durat/Int(endValue)
        if durat%Int(endValue) != 0 {
            loop+=1
        }
        
        let asyncGroup = DispatchGroup()
        
        for index in 0...loop-1{
            asyncGroup.enter()
            let startTime:Float = index == 0 ? 0 : (Float(index) * endValue)
            let endTime:Float = index != loop-1 ?  index == 0 ? endValue : Float(index+1) * endValue : Float(durat)
            print("=====> ST: \(startTime) :: ET: \(endTime) :: EV: \(endValue) :: DR \(Float(durat))")
            
            cropVideo(sourceURL1: urls, startTime: startTime, endTime: endTime) { (status) in
                asyncGroup.leave()
            }
        }
        asyncGroup.notify(queue: DispatchQueue.main) {
            self.player.pause()
            
            self.sharing()
        }
      
    }
    
    typealias CropComplete = (_ status: Bool) -> Void
    func cropVideo(sourceURL1: NSURL, startTime:Float, endTime:Float, cropComplete: @escaping CropComplete)
    {
        let manager                 = FileManager.default
        
        guard let documentDirectory = try? manager.url(for: .documentDirectory,
                                                       in: .userDomainMask,
                                                       appropriateFor: nil,
                                                       create: true) else {return}
        guard let mediaType         = "mp4" as? String else {return}
        guard (sourceURL1 as? NSURL) != nil else {return}
        
        if mediaType == kUTTypeMovie as String || mediaType == "mp4" as String
        {
            print(asset2)
            let length = Float(asset2.duration.value) / Float(asset2.duration.timescale)
            print("video length: \(length) seconds")
            let start = startTime
            let end = endTime
            print(documentDirectory)
            
            var outputURL = documentDirectory.appendingPathComponent("output")
            do {
                //                                for index in 0...loop-1{
                //                                    numberUrl.append(index+1)
                //                                    try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                //                                    outputURL = outputURL.appendingPathComponent("\(numberUrl[index]).mp4")
                let number = Int.random(in: 0..<50)
                try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                //let name = hostent.newName()
                outputURL = outputURL.appendingPathComponent("\(number).mp4")
                
                //                                }
            }catch let error {
                print(error)
            }
            
            //Remove existing file
            _ = try? manager.removeItem(at: outputURL)
            
            guard let exportSession = AVAssetExportSession(asset: asset2, presetName: AVAssetExportPresetHighestQuality) else {return}
            exportSession.outputURL = outputURL
            exportSession.outputFileType = AVFileType.mp4
            urlSharing.append(exportSession.outputURL! as NSURL)
            var startTime = CMTime(seconds: Double(start ), preferredTimescale: 1000)
            var endTime = CMTime(seconds: Double(end ), preferredTimescale: 1000)
            var timeRange = CMTimeRange(start: startTime, end: endTime)
            exportSession.timeRange = timeRange
            
            print(exportSession.status)
            
            //            SVProgressHUD.show(withStatus: "Loading...")
            
            exportSession.exportAsynchronously{
                switch exportSession.status {
                
                case .completed:
                    
                    print("exported at \(outputURL)")
                    print(self.urlSharing)
                    
                    print(exportSession.progress)
                    //                    SVProgressHUD.show()
                    
                    cropComplete(true)
                    
                    DispatchQueue.main.async {
                        print(outputURL)
                        self.saveToCameraRoll(URL:outputURL as NSURL?)
                    }
                    print(exportSession.progress)
                    
                    
                case .failed:
                    print("failed \(exportSession.error)")
                    
                case .cancelled:
                    print("cancelled \(String(describing: exportSession.error))")
                    
                default:
                    print(exportSession.status)
                    break
                    
                }
                
            }
            
        }
        
    }
    //Save Video to Photos Library
    func saveToCameraRoll(URL: NSURL!) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL as URL)
            //            SVProgressHUD.dismiss()
            
        }) { saved, error in
            if saved {
                
                //                SVProgressHUD.dismiss()
                print("Cropped video was saved successfully")
                let alertController = UIAlertController(title: "videoEditing", message:
                                                            "Cropped video was saved successfully", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
                
                //                SVProgressHUD.dismiss()
            }}}
    
    
}
extension CutterViewController{
    
    func numberOfVideo(value:Int) -> Void {
        
        if thumbtimeSeconds != nil{
            
            var noLoop=thumbtimeSeconds/value
            if thumbtimeSeconds%value != 0 {
                noLoop+=1
            }
            print(noLoop)
            
            var numloop = UserDefaults.standard.set(noLoop, forKey: "noOfLoop")
            numOfVideo.text = "\(UserDefaults.standard.integer(forKey: "noOfLoop"))"
        }
        
    }
    func sharing(){
        let sc = self.storyboard?.instantiateViewController(withIdentifier: "VideoTableViewController") as? VideoTableViewController
        
        print(self.urlSharing)
        sc?.url(video: urlSharing)
        self.navigationController?.pushViewController(sc!, animated: true)
        
    }
    
    
    
    
}



extension CutterViewController:MuteDelegate{
    
    func Mute(Url: AVAssetExportSession) {
        
        print("DoneDone")
        vc.url = Url.outputURL as NSURL?
        vc.asset = Url.asset
        asset2 = vc.asset
        
        UserDefaults.standard.set(Url.outputURL! as URL, forKey: "urlVideo")
        
    }
    
    
}

extension CutterViewController:AddSoundDelegate{
    
    func AddSound(Asset: AVAssetExportSession) {
        print("DoneDone")
        print("\(Asset.outputURL as NSURL?)")
        vc.url = Asset.outputURL as NSURL?
        
        vc.asset = Asset.asset
        asset2 = vc.asset
        
        UserDefaults.standard.set(Asset.outputURL! as URL, forKey: "urlVideo")
        
    }
    
}

