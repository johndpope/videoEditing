//
//  L102Language.swift
//  Advertiser
//
//  Created by Momen Sisalem on 1/24/18.
//  Copyright © 2018 Momen Sisalem. All rights reserved.
//

import Foundation
import UIKit

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class L102Language {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        return currentWithoutLocale
    }
    
    class func currentAppleLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
    class var isRTL: Bool {
        return L102Language.currentAppleLanguage() == "ar"
    }
    
    class func changeLanguage(view: UIViewController, newLang: String, rootViewController: String)  {
        var transition: UIView.AnimationOptions = .transitionFlipFromLeft
        if L102Language.currentAppleLanguage() != newLang {
            if newLang == "ar" {
                print("Change To AR")
                L102Language.setAppleLAnguageTo(lang: "ar")
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }else if newLang == "en"{
                print("Change to EN")
                L102Language.setAppleLAnguageTo(lang: "en")
                transition = .transitionFlipFromRight
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
            
            let rootviewcontroller: UIWindow = UIApplication.shared.windows.first!
            rootviewcontroller.rootViewController = view.storyboard?.instantiateViewController(withIdentifier: rootViewController)
            let mainwindow = UIApplication.shared.windows.first!
            mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
            UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
            }) { (finished) -> Void in
                
            }
            
//            let vc = view.storyboard?.instantiateViewController(withIdentifier: rootViewController)
//            let appDlg = UIApplication.shared.delegate as? AppDelegate
//            appDlg?.window?.rootViewController = vc
        }
    }
    
    class func changeRunLanguage(newLang: String)  {
        if L102Language.currentAppleLanguage() != newLang {
            if newLang == "ar" {
                print("Change To AR")
                L102Language.setAppleLAnguageTo(lang: "ar")
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }else if newLang == "en"{
                print("Change to EN")
                L102Language.setAppleLAnguageTo(lang: "en")
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
        }
    }
}
