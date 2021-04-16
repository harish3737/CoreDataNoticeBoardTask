//
//  NoticeListVC.swift
//  CoreDataPractice
//
//  Created by AppleMac on 16/04/21.
//  Copyright © 2021 Abservetech. All rights reserved.
//

import UIKit

class NoticeListVC: UIViewController {
    
    @IBOutlet weak var logoutImg : UIImageView!
    @IBOutlet weak var noticeCollection : UICollectionView!
    @IBOutlet weak var createNoticeBtn : UIButton!
    @IBOutlet weak var nameLbl : UILabel!

    var presistentManager : PresistentManager!
    
    var userDetail : User?
    
    var noticevm = NoticeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noticevm = NoticeVM(vc: self)
        
        self.presistentManager = PresistentManager.shared
        self.setupView()
        self.getUserDetail()
        self.setupAction()
        self.createNoticeBtn.setTitle("Create Notice", for: .normal)
        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.noticeCollection.reloadData()
    }
    
    func setupView(){
        self.createNoticeBtn.layer.cornerRadius = 20
        self.createNoticeBtn.backgroundColor = .primaryColor
        self.createNoticeBtn.setTitleColor(.whiteColor, for: .normal)
    }

    func setupAction(){
        self.createNoticeBtn.addTap {
            let vc = CreateNoticeVC.initVC(storyBoardName: .main, viewConrollerID: .CreateNoticeVC) as! CreateNoticeVC
            vc.userDetail = self.userDetail
            self.push(from: self, ToViewContorller: vc)
        }
        
        self.logoutImg.addTap {
            self.presistentManager.deleteAllData(User.self)
            
            UIApplication.shared.windows.last?.rootViewController?.pop(from: self)
           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitialVC") as! InitialVC
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.isNavigationBarHidden = true
            
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }
    }
    
    func getUserDetail(){
        let users = self.presistentManager.fetch(User.self)
        
        if users.count > 0{
            self.userDetail = users.first
            self.nameLbl.text = users.first?.username?.capitalized
            if (users.first?.type ?? "") == "teacher"{
                self.createNoticeBtn.isHidden = false
            }else{
                self.createNoticeBtn.isHidden = true
            }
        }
    }
}

extension NoticeListVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return  self.noticevm.noticeCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.NoticeCell.rawValue, for: indexPath) as! NoticeCell
        let cellData = self.noticevm.noticeList()[indexPath.row]
        cell.noticeTitle.text = cellData.title
        cell.dateLbl.text = cellData.date
        cell.teacherNameLbl.text = cellData.teacher
        if cellData.imagedata != nil{
            cell.noticeImg.image = UIImage(data: cellData.imagedata ?? Data())
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screen = UIScreen.main.bounds
        
        return CGSize(width: 180, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ViewNoticeVC.initVC(storyBoardName: .main, viewConrollerID: .ViewNoticeVC) as! ViewNoticeVC
        vc.userDetail = self.userDetail
        vc.notice =  self.noticevm.noticeList()[indexPath.row]
        self.push(from: self, ToViewContorller: vc)
        
        
    }
    
    func setupCollectionView(){
        self.noticeCollection.delegate = self
        self.noticeCollection.dataSource = self
        self.noticeCollection.registerCell(withId: .NoticeCell)
    }
}


extension UICollectionView{
    func registerCell(withId id : CellID){
        self.register(UINib(nibName: id.rawValue, bundle: Bundle.main), forCellWithReuseIdentifier: id.rawValue)
    }
    
}
