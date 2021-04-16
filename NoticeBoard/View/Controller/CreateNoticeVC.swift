//
//  CreateNoticeVC.swift
//  CoreDataPractice
//
//  Created by AppleMac on 16/04/21.
//  Copyright © 2021 Abservetech. All rights reserved.
//

import UIKit

class CreateNoticeVC: UIViewController {
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var backImg : UIImageView!
    
    @IBOutlet weak var titleTxt : UITextField!
    @IBOutlet weak var noticeTxt : UITextView!
    @IBOutlet weak var noticeImg : UIImageView!
    
    @IBOutlet weak var submit : UIButton!
    
    var isImageUpload : Bool?
    var userDetail : User?

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
        
        self.noticeImg.addTap {
            self.showImage(isRemoveNeed: nil, with:{ (image) in
                self.noticeImg.image = image
                self.isImageUpload = true
            })
        }
        
        self.submit.addTap {
            self.noticevm.Validation()
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
        if (userDetail?.type ?? "") == "teacher"{
           
        }else{
            self.submit.isHidden = true
        }
    }
}
