

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var vc : UIViewController!
        let users = PresistentManager.shared.fetch(User.self)
        
        if users.count > 0{
            
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoticeListVC") as! NoticeListVC
        }else{
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitialVC") as! InitialVC
        }
         
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.tintColor = UIColor.white
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = navigationController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        PresistentManager.shared.save()
    }

    

}

