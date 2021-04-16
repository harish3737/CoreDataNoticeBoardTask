

import UIKit

class NoticeVM {
    
    var vc : UIViewController!
    
    var presistentManager : PresistentManager!
    
    func noticeCount() -> Int{
        
        guard let _ = vc else {
            return 0
        }
        
        let vc = self.vc as! NoticeListVC
        
        let notice = presistentManager.fetch(Notice.self)
        if notice.count > 0 {
        if (vc.userDetail?.type ?? "") == "teacher"{
            let teacherNotice : [Notice] = notice.filter({$0.teacher == vc.userDetail?.username ?? ""})
            return teacherNotice.count
        }else{
              return notice.count
            }
        }
       return 0
    }
    
    func noticeList() -> [Notice]{
        guard let _ = vc else {
            return []
        }
        
        let vc = self.vc as! NoticeListVC
        
        let notice = presistentManager.fetch(Notice.self)
        if notice.count > 0 {
            if (vc.userDetail?.type ?? "") == "teacher"{
                let teacherNotice : [Notice] = notice.filter({$0.teacher == vc.userDetail?.username ?? ""})
                return teacherNotice
            }else{
                return notice
            }
        }
        return []
    }
    
    
    
    init(){}
    
    init(vc : UIViewController) {
        self.vc = vc
        self.presistentManager = PresistentManager.shared
    }
}

extension NoticeVM{
    
    func Validation(){
        guard let _ = vc else {
            return
        }
        
        let vc = self.vc as! CreateNoticeVC
        
        guard let title = vc.titleTxt.text , !title.isEmpty  else {
            showToast(msg: ErrorMsg.enterFirstName.localize)
            return
        }
        
        guard let notice = vc.noticeTxt.text , !notice.isEmpty  else {
            showToast(msg: ErrorMsg.enterdis.localize)
            return
        }
        
        let user = Notice(context:presistentManager.context)
        user.title = title
        user.notice = notice
        user.teacher = vc.userDetail?.username ?? ""
        if vc.isImageUpload ?? false{
            user.imagedata = vc.noticeImg.image?.pngData()
        }
        user.date = dateFor()
        presistentManager.save()
        
        vc.navigationController?.pop(from: vc)
    }
    
    func dateFor()-> String{
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        print(formatter1.string(from: today))
        return formatter1.string(from: today)
    }
    
    
    func fetchNoticeDetail(){
        let notice = presistentManager.fetch(Notice.self)
        if notice.count > 0 {
            self.noticeCount()
            self.noticeList()
        }
        
        guard let _ = vc else {
            return
        }
        
        let vc = self.vc as! NoticeListVC
        vc.noticeCollection.reloadData()
        
    }
}
