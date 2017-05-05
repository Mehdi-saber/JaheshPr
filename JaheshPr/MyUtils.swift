//
//  MyUtils.swift
//  ARToolKit5iOS
//
//  Created by mehdi sabermahani on 4/21/17.
//
//

import UIKit
import Alamofire

class MyUtils: NSObject {
    static func imageWithImage(_ image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!;
    }
    static func saveToDefaults(_ key:String, newValue value:Any){
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        preferences.synchronize()
    }
    static func loadFromDefault(_ key:String)->Any?{
        let preferences = UserDefaults.standard
        return preferences.string(forKey: key)
    }
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static  func getDicFromPlist(filename:String)->[String:String]?{
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: filename, ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        return myDict as? [String : String]
    }
}
