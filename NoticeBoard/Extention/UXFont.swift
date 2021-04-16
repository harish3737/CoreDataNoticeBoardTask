

import UIKit
//Custom font type
enum FontType: String {
    case bold = "Biotif-Bold"
    case medium = "Biotif-Medium"
    case light = "Biotif-Light"
    case semibold = "Biotif-SemiBold"
    case regular = "Biotif-Regular"
}

//Custom font size
enum FontSize: CGFloat {
    case x8 = 8.0
    case x10 = 10.0
    case x12 = 12.0
    case x13 = 13.0
    case x14 = 14.0
    case x16 = 16.0
    case x18 = 18.0
    case x20 = 20.0
    case x22 = 22.0
    case x24 = 24.0
    case x26 = 26.0
    case x28 = 28.0
    case x30 = 30.0
    case x35 = 35.0
    case x50 = 50.0
    case x60 = 60.0
    
}

//Set Custom font and size
extension UIFont {
    
    class func setCustomFont(name: FontType, size: FontSize) -> UIFont {
        return UIFont(name: name.rawValue, size: size.rawValue) ?? UIFont.systemFont(ofSize: 16)
    }
}



extension UIView{
    func addBlurView(){
        var blurEffect : UIBlurEffect!
        blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.alpha = 1
        blurView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(blurView)
    }
}
