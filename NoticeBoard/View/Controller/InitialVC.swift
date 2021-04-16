

import UIKit

enum InitialPage : String{
    case school
    case parent
}

class InitialVC: UIViewController {
    
    @IBOutlet weak var logo : UIImageView!
    
    @IBOutlet weak var signupBtn : UIButton!
    @IBOutlet weak var loginBtn : UIButton!
    
    
    @IBOutlet weak var parentBtn : UIButton!
    @IBOutlet weak var schoolBtn : UIButton!
    
    var pageSelection : InitialPage = .parent{
        didSet{
            if pageSelection == .parent{
                self.parentBtn.setCorneredElevation(shadow: 1, corner: 25, color: .gray)
                self.schoolBtn.setCorneredElevation(shadow: 1, corner: 25, color: .gray)
                self.parentBtn.backgroundColor = .primaryColor
                self.parentBtn.setTitleColor(.white, for: .normal)
                self.schoolBtn.backgroundColor = .white
                self.schoolBtn.setTitleColor(.primaryColor, for: .normal)
                self.schoolBtn.layer.borderColor = UIColor.primaryColor.cgColor
                self.schoolBtn.layer.borderWidth = 1
                self.view.bringSubviewToFront(self.parentBtn)
            }else{
                self.schoolBtn.setCorneredElevation(shadow: 1, corner: 25, color: .gray)
                self.parentBtn.setCorneredElevation(shadow: 1, corner: 25, color: .gray)
                self.schoolBtn.backgroundColor = .primaryColor
                self.schoolBtn.setTitleColor(.white, for: .normal)
                self.parentBtn.layer.borderColor = UIColor.primaryColor.cgColor
                self.parentBtn.setTitleColor(.primaryColor, for: .normal)
                self.parentBtn.layer.borderWidth = 1
                self.parentBtn.backgroundColor = .white
                self.view.bringSubviewToFront(self.schoolBtn)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        self.logo.layer.cornerRadius = 20
        self.pageSelection = .parent
    }
    
}

extension InitialVC {
    func initialLoad(){
        self.signupBtn.setButton(titleColor: .whiteColor, bgColor: .blackColor, cornerRadius: 5, borderWith: 2, borderColor: .whiteColor)
        self.loginBtn.setButton(titleColor: .primaryColor, bgColor: .whiteColor, cornerRadius: 5)
    
         [self.signupBtn,self.loginBtn].forEach { (btn) in
            btn?.titleLabel?.font = .setCustomFont(name: .bold, size: .x18)
        }
        
        self.localize()
        self.setupAction()
    }
    
    func localize(){
     
        self.signupBtn.text = Lng.signup.localize
        self.loginBtn.text = Lng.login.localize
        
        
        self.parentBtn.setTitle(Lng.parent.localize, for: .normal)
        self.schoolBtn.setTitle(Lng.school.localize, for: .normal)
    }
    
    func setupAction(){
        self.loginBtn.addTap {
            let vc = LoginSignupVC.initVC(storyBoardName: .main, viewConrollerID: .LoginSignupVC) as? LoginSignupVC
            vc?.pushedView = .login
            vc?.pageFrom = self.pageSelection
            self.push(from: self, ToViewContorller: vc!)
        }
        self.signupBtn.addTap {
            let vc = LoginSignupVC.initVC(storyBoardName: .main, viewConrollerID: .LoginSignupVC) as? LoginSignupVC
            vc?.pushedView = .signup
            vc?.pageFrom = self.pageSelection
            self.push(from: self, ToViewContorller: vc!)
        }
        
        self.parentBtn.addTap {
            self.pageSelection = .parent
        }
        self.schoolBtn.addTap {
            self.pageSelection = .school
        }
    }
}
