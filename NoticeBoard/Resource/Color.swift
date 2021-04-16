
import Foundation
import UIKit

extension UIColor {
    public static var primaryColor : UIColor{
        UIColor(named: R.Color.primary_color)!
    }
    public static var offerColor : UIColor{
           UIColor(named: R.Color.offer_red)!
       }
    
    public static var placeHolderColor : UIColor{
        UIColor(named: R.Color.light_gray)!
    }
       
    public static var whiteColor : UIColor{
        if #available(iOS 13.0, *) {
           return UIColor(named: R.Color.white_color)!
        } else {
           return UIColor.white
        }
    }
    
    public static var blackColor : UIColor{
          if #available(iOS 13.0, *) {
             return UIColor(named: R.Color.black_color)!
          } else {
             return UIColor.black
          }
      }
    
    public static var grayColor : UIColor{
        if #available(iOS 13.0, *){
            return UIColor.systemGray
        }else{
            return UIColor(named: R.Color.gray_color)!
        }
    }
    
    public static var lightGrayColor : UIColor{
           if #available(iOS 13.0, *){
               return UIColor.systemGray2
           }else{
               return UIColor(named: R.Color.light_gray)!
           }
       }
    
   
    public static var MenuGradiansuperTop : UIColor{
       Color(hex: "#2E6A18")
    }
    public static var MenuGradianTop : UIColor{
        UIColor(named: R.Color.primary_color)!
    }
    public static var MenuGradianMiddle : UIColor{
       Color(hex: "#67A600")
    }
    public static var unReadNotify : UIColor{
        UIColor(named: R.Color.unread_notify)!
    }
    public static var MenuGradianBottom : UIColor{
        Color(hex: "#9EB936") //67A600
    }
    public static var yellowishGreen : UIColor{
        Color(hex: "#9EB936")
    }
    
    public static var infowWindow : UIColor{
        Color(hex: "#1F2124")
    }
    
    public static var none : UIColor{
        UIColor.init()
    }
    
   public static func randomColor() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 0.8
        )
    }
    
}


func Color (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
    
    
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
