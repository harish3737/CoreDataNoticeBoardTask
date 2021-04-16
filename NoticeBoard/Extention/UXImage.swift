

import Foundation
import UIKit


    enum AssetName : String{
        case menu = "Menu"

    }

enum SystemName : String{

    case left_arrow = "chevron.left"
}

enum LottieName : String{
    case start_ride = "car_animate"
}
    
extension UIImageView{
    
  
   
    func setImage(_ name : AssetName , _ withTint : YesNo = .no, _ withTintColor : UIColor = UIColor.whiteColor ){
        if withTint == .no{
            self.image = (UIImage(named: name.rawValue) ?? UIImage())
        }else{
            if #available(iOS 13.0, *) {
                self.image = (UIImage(named: name.rawValue) ?? UIImage()).withTintColor(withTintColor)
            } else {
                if let TintImage = (UIImage(named: name.rawValue)){
                    let tintableImage = TintImage.withRenderingMode(.alwaysTemplate)
                    self.image = tintableImage
                }
                self.tintColor = withTintColor
                self.image = self.image?.imageWithColor(color: withTintColor)
            }
        }
    }
    
    func setURLImage(_ url : String){
        if !url.isEmpty{
//        self.pin_setImage(from: URL(string: url)!)
        }
    }
    
    func getURLImage(_ url : String) -> UIImage{
        let testImage = UIImageView()
        testImage.setURLImage(url)
        return testImage.image ?? UIImage()
    }
    
    }

func getImage(_ name : AssetName , _ withTint : YesNo = .no, _ withTintColor : UIColor = UIColor.whiteColor )-> UIImage{
      if withTint == .no{
          return (UIImage(named: name.rawValue) ?? UIImage())
         
      }else{
          if #available(iOS 13.0, *) {
             return (UIImage(named: name.rawValue) ?? UIImage()).withTintColor(withTintColor)
          } else {
             let testImage = UIImageView()
            testImage.image = (UIImage(named: name.rawValue) ?? UIImage())
              testImage.tintColor = withTintColor
            return testImage.image ?? UIImage()
          }
      }
  }


extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

