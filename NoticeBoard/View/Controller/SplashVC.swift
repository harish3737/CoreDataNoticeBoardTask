


import UIKit

class SplashVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.push(from: self, ToViewContorller: InitialVC.initVC(storyBoardName: .main, viewConrollerID: .InitialVC))
    }
}


