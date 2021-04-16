

import UIKit

class LoginSignupVM{
    
    var vc : UIViewController!
    
    
    var presistentManager : PresistentManager!
    
    var Success : InitialPage = .parent{
        didSet{
            UserDefaultConfig.type = Success.rawValue
            let homeVc = NoticeListVC.initVC(storyBoardName: .main, viewConrollerID: .NoticeListVC) as! NoticeListVC
            self.vc.push(from: self.vc, ToViewContorller: homeVc)
        }
    }
    
  
    
    init(){}
    
    init(vc : UIViewController) {
        self.vc = vc
        self.presistentManager = PresistentManager.shared
    }
}


extension LoginSignupVM{
    func LoginValidation(){
            guard let _ = vc else {
                return
            }
        
            let vc = self.vc as! LoginSignupVC
            guard let email = vc.emailTxt.text , !email.isEmpty , email.isValidEmail() else {
                showToast(msg: ErrorMsg.enterEmail.localize)
                return
            }
            guard let password = vc.passwordTxt.text , !password.isEmpty , password.count > 5 else {
                showToast(msg: ErrorMsg.enterPassword.localize)
                return
            }
            
        if vc.selectedPage == .parent{
            let users = presistentManager.fetch(Parent.self)
            if users.count > 0{
                let user = users.filter({$0.email == email && $0.password == password})
                if user.count > 0{
                    self.updateUserData(name: user.first?.name ?? "", email: user.first?.email ?? "", page: .parent)
                }else{
                    showToast(msg: "Invalid Credentials")
                }
            }else{
                showToast(msg: "Parents Details Not Found,Please Signup")
            }
           
        }else{
            
            let users = presistentManager.fetch(School.self)
            if users.count > 0{
                let user = users.filter({$0.email == email && $0.password == password})
                if user.count > 0{
                    self.updateUserData(name: user.first?.name ?? "", email: user.first?.email ?? "", page: .school)
                }else{
                    showToast(msg: "Invalid Credentials")
                }
            }else{
                showToast(msg: "School Details Not Found,Please Signup")
            }
           
        }
        
        
    }
    
    func updateUserData(name : String,email : String,page : InitialPage){
        self.presistentManager.deleteAllData(User.self)
        let saveuser = User(context:presistentManager.context)
        saveuser.username = name
        saveuser.email = email
        if page == .parent{
            saveuser.type = "parent"
        }else{
            saveuser.type = "teacher"
        }
        presistentManager.save()
        Success = page
    }
    
    
    func signupValidation(){
        guard let _ = vc else {
            return
        }
        
        let vc = self.vc as! LoginSignupVC
        
        guard let firstName = vc.nameTxt.text , !firstName.isEmpty  else {
            showToast(msg: ErrorMsg.enterFirstName.localize)
            return
        }
       
       
        guard let email = vc.emailTxt.text , !email.isEmpty , email.isValidEmail() else {
            showToast(msg: ErrorMsg.enterEmail.localize)
            return
        }
        
       
        guard let password = vc.passwordTxt.text , !password.isEmpty , password.count > 5 else {
            showToast(msg: ErrorMsg.enterPassword.localize)
            return
        }
        
        guard let confirmPass = vc.confirmPasswordTxt.text , !confirmPass.isEmpty , confirmPass.count > 5 else {
            showToast(msg: ErrorMsg.enterConfirmPassword.localize)
            return
        }
        
        if password != confirmPass{
            showToast(msg: ErrorMsg.matchPassword.localize)
        }
        
        
        if vc.selectedPage == .parent{
            
            let user = Parent(context:presistentManager.context)
            user.name = firstName
            user.email = email
            user.password = password
            presistentManager.save()
            
            self.updateUserData(name: firstName, email: email, page: .parent)
        }else{
            
            let user = School(context:presistentManager.context)
            user.name = firstName
            user.email = email
            user.password = password
            presistentManager.save()
            
            self.updateUserData(name: firstName, email: email, page: .school)
        }
        
        
        
    }
}

extension LoginSignupVM{
   
}




