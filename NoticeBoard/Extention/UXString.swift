

import Foundation
import UIKit


let Localize : Localizations = Localizations.instance

extension String{
    var localize : String{
        Localize.stringForKey(key: self)
    }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
          let attributedString = NSMutableAttributedString(string: self)
          for string in strings {
              let range = (self as NSString).range(of: string)
              attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
          }

          guard let characterSpacing = characterSpacing else {return attributedString}

          attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

          return attributedString
      }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isPhoneNumber: Bool {
        let phoneRegex = "^(()|(00))[0-9]{6,14}$"
        let PhoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        return PhoneTest.evaluate(with: self)   }
    
    func LicenseValidation() -> Bool{
        let decimalCharacters = CharacterSet.decimalDigits

        let decimalRange = self.rangeOfCharacter(from: decimalCharacters)

        if decimalRange != nil {
            let space = CharacterSet.whitespaces

            let spaceRange = self.rangeOfCharacter(from: decimalCharacters)
            
            if spaceRange != nil {
                let chatr = CharacterSet.letters

                let chatrRange = self.rangeOfCharacter(from: decimalCharacters)
                
                if chatrRange != nil{
                     return true
                }else{
                    return false
                }

            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        
        var chars = Array(myString)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    
}
