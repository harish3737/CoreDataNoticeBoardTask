
import UIKit

extension UIButton{
    
    var text : String{
        set(newValue){
            self.setTitle(newValue, for: .normal)
            
        }
        get{
            return self.title(for: .normal) ?? ""
        }
    }
    
    func setButton(titleColor tc : UIColor = .none,bgColor bg : UIColor = .none,cornerRadius cr : Int = 0,borderWith bw : Int = 0,borderColor bc: UIColor = .primaryColor){
        self.setTitleColor(tc, for: .normal)
        self.backgroundColor = bg
        self.layer.cornerRadius = CGFloat(cr)
        self.layer.borderWidth = CGFloat(bw)
        self.layer.borderColor = bc.cgColor
        
    }
    
    
}
