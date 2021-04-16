
import UIKit

class LoginSignupVC: UIViewController {
    
    @IBOutlet weak var loginHeaderBtn : UIButton!
    @IBOutlet weak var signupHeaderBtn : UIButton!
    
    @IBOutlet weak var headerstackView : UIStackView!
    
    @IBOutlet weak var nameTxt : HoshiTextField!
    @IBOutlet weak var emailTxt : HoshiTextField!
    @IBOutlet weak var passwordTxt : HoshiTextField!
    @IBOutlet weak var confirmPasswordTxt : HoshiTextField!
    @IBOutlet weak var submitBtn : UIButton!
    
    @IBOutlet weak var TitleLbl : UILabel!
    @IBOutlet weak var backImg : UIImageView!
    
    var pushedView : Loginsignup = .login
    var pageFrom : InitialPage = .parent
    
    var selectedView : Loginsignup = .login{
        didSet{
            switch selectedView {
                case .login:
                    self.headerstackView.removeArrangedSubview(self.loginHeaderBtn)
                    self.headerstackView.insertArrangedSubview(self.loginHeaderBtn, at: 0)
                    [self.nameTxt,self.confirmPasswordTxt].forEach { (txf) in
                        txf?.isHidden = true
                        txf?.text = ""
                    }
                    self.submitBtn.text = Lng.login.localize
                case .signup:
                    self.headerstackView.removeArrangedSubview(self.signupHeaderBtn)
                    self.headerstackView.insertArrangedSubview(self.signupHeaderBtn, at: 0)
                    self.submitBtn.text = Lng.signup.localize
                    [self.nameTxt,self.confirmPasswordTxt,self.emailTxt,self.passwordTxt].forEach { (txf) in
                        txf?.isHidden = false
                        txf?.text = ""
                    }
                    
            }
        }
    }
    
    var selectedPage : InitialPage = .parent{
        didSet{
            switch selectedPage {
                case .parent:
                    self.TitleLbl.text = Lng.parent.localize.capitalized
                case .school:
                    self.TitleLbl.text = Lng.school.localize.capitalized
                    
            }
        }
    }
    
    
    var loginSignupVM = LoginSignupVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginSignupVM = LoginSignupVM(vc: self)
        self.initialLoad()
        self.selectedView = self.pushedView
        self.selectedPage  = self.pageFrom
    }
    
    
    
}

extension LoginSignupVC{
    func initialLoad(){
        self.setupAction()
        self.localize()
        
        [self.loginHeaderBtn , self.signupHeaderBtn].forEach { (btn) in
            btn?.setButton(titleColor: .whiteColor, bgColor: .clear)
            btn?.titleLabel?.font = .setCustomFont(name: .bold, size: .x20)
            self.submitBtn.titleLabel?.font = .setCustomFont(name: .bold, size: .x20)
        }
        
        self.TitleLbl.font = .setCustomFont(name: .bold, size: .x20)
        self.TitleLbl.textColor = .whiteColor
        self.submitBtn.setButton(titleColor: .whiteColor, bgColor: .primaryColor, cornerRadius: 20, borderWith: 0, borderColor: .clear)
        
        self.setupTextFeild()
    }
    
    func localize(){
        self.loginHeaderBtn.text = Lng.login.localize
        self.signupHeaderBtn.text = Lng.signup.localize
        
        nameTxt.placeholder = Lng.name.localize
        emailTxt.placeholder = Lng.email.localize
        confirmPasswordTxt.placeholder = Lng.confirmPassword.localize
        passwordTxt.placeholder = Lng.password.localize
        
    }
    
    func setupAction(){
        self.loginHeaderBtn.addTap {
            self.selectedView = .login
        }
        
        self.signupHeaderBtn.addTap {
            self.selectedView = .signup
        }
        
        self.backImg.addTap {
            self.navigationController?.pop(from: self)
        }
        
        self.submitBtn.addTap {
            
            if self.selectedView == .login{
                self.loginSignupVM.LoginValidation()
            }else{
                self.loginSignupVM.signupValidation()
            }
            
            
        }
    }
    
    func setupTextFeild(){
        
        [self.nameTxt,self.emailTxt,self.confirmPasswordTxt,self.passwordTxt].forEach { (textfeild) in
            textfeild?.borderActiveColor = .primaryColor
            textfeild?.borderInactiveColor = .lightGray
            textfeild?.placeholderColor = .placeHolderColor
            textfeild?.textColor = .blackColor
            textfeild?.delegate = self
            textfeild?.font = .setCustomFont(name: .semibold, size: .x24)
        }
        
        
       
    }
}


extension LoginSignupVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
        }
    }
    
}
