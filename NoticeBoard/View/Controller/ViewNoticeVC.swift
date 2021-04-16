
import UIKit

class ViewNoticeVC: UIViewController {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var backImg : UIImageView!
    
    @IBOutlet weak var titleTxt : UITextField!
    @IBOutlet weak var noticeTxt : PaddingLabel!
    @IBOutlet weak var noticeImg : UIImageView!
    
    @IBOutlet weak var teacherName : UITextField!
    @IBOutlet weak var dateLbl : UITextField!
    
    @IBOutlet weak var submit : UIButton!
    
    var userDetail : User?
    var notice : Notice?
    
    var noticevm = NoticeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noticevm = NoticeVM(vc: self)
        self.setupAction()
        self.setupView()
        self.setupData()
    }
    
    func setupAction(){
        self.backImg.addTap {
            self.navigationController?.pop(from: self)
        }
        
       
     
    }
    
    func setupView(){
        [self.titleTxt,self.noticeTxt,self.noticeImg,self.submit].forEach { (view) in
            view?.layer.cornerRadius = 15
        }
        
        submit.backgroundColor = .primaryColor
        submit.setTitleColor(.whiteColor, for: .normal)
        submit.setTitle("Submit", for: .normal)
    }
    
    func setupData(){
     
            self.titleTxt.text = self.notice?.title ?? ""
            self.noticeTxt.text = self.notice?.notice ?? ""
            if self.notice?.imagedata != nil{
                self.noticeImg.image = UIImage(data: self.notice?.imagedata ?? Data())
            }
            self.teacherName.text = self.notice?.teacher ?? ""
            self.dateLbl.text = self.notice?.date ?? ""
        
    }
}
