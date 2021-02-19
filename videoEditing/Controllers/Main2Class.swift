import Foundation
import UIKit
class Main2Class{
    var tick:CutterViewController?
    public var imageName:String?

    init(imageName:String) {
        self.imageName=imageName
    }
}

enum MainCategory{
    
case snapShat
case whatsapp
case messenger
case instagram
case youTube
case tikTok
    
    var imageName:UIImage?{
        
    
        switch self {
         case .snapShat:
               return UIImage.init(named: "snapchat")
            
         case .whatsapp:
                return UIImage.init(named: "whatsapp")
            
          case .messenger:
                return UIImage.init(named: "messenger")
            
          case .instagram:
                return UIImage.init(named: "instagram-sketched")
            
          case .youTube:
                return UIImage.init(named: "youtube")
            
          case .tikTok:
                return UIImage.init(named: "tiktok (1)")

        }
        
   
    }
  
}
    
    
    

    
    
    
    
    
    

