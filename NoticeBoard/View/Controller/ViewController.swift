
import UIKit
import CoreData

class ViewController: UIViewController {

    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var presistentManager : PresistentManager!
    var users = [User]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presistentManager = PresistentManager.shared
        print("Came to viewcontroller")
        self.saveData()
        self.getData()
//        self.deleteAlldata()
       
    }

    // Manualy create Entity and manage Object
    
    func saveManualEntityData(){
        let context = presistentManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "School", in: context)
        let newuser = NSManagedObject(entity: entity!, insertInto: context)
        newuser.setValue("Saranya", forKey: "username")
        newuser.setValue("30", forKey: "age")
        do{
            try! context.save()
            print("####Data saved successfully")
        }catch{
            print("@@@@Error in coredata")
        }
    }
    
    func fetchManualEntityData(){
        let context = presistentManager.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchrequest.returnsObjectsAsFaults = false
        do{
          let result = try! context.fetch(fetchrequest)
            print("####result" , result)
            for data in result as! [NSManagedObject] {
                print("ValueinDB===>",data.value(forKey: "username"))
            }
        }catch{
            print("@@@@Error in fetch data")
        }
    }
 
    //by create ManageObject we create Some object
    
    func saveData(){
        let user = School(context:presistentManager.context)//User(context: presistentManager.context)
        user.name = "Barath"
        user.email = "20"
        user.password = "20"
        presistentManager.save()
    }
    
    func getData(){
//        guard let userData =  try! presistentManager.context.fetch(User.fetchRequest()) as? [User] else {return}

        
        let users = presistentManager.fetch(School.self)
//        self.users = users
        users.forEach({
            print("Data" , $0)
        })
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//            self.updateData()
//            self.deleteData()
        }
    }
    
    func updateData(){
        let user = users[users.count-3]
        user.username = " And saranyas are sisters"
        presistentManager.save()
    }
    
    func deleteData(){
        let user = users.first!
        presistentManager.delete(user)
        //        presistentManager.context.delete(user)
//        presistentManager.save()
    }
    
    func deleteAlldata(){
        presistentManager.deleteAllData(User.self)
    }
}

