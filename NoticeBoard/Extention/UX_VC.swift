

import Foundation
import UIKit
import AVKit


private var imageCompletion : ((UIImage?)->())?

extension UIViewController{
    var identifiers : String{
        return "\(self)"
    }

    //MARK:- Generic type of calling a class
    
    static func initVC<T : UIViewController>(storyBoardName name : StoryboardName ,  viewConrollerID id : VCID) -> T{
        return getStoryBoard(withName: name).instantiateViewController(withIdentifier: id.rawValue) as! T
    }
    
    func push<T : UIViewController>(from vc : T ,ToViewContorller contoller : UIViewController ){
        vc.navigationController?.pushViewController(contoller, animated: true)
    }
    
    func pop<T:UIViewController>(from vc : T){
        vc.navigationController?.popViewController(animated: true)
    }
}

func getStoryBoard(withName name : StoryboardName) -> UIStoryboard{
    return UIStoryboard.init(name: name.rawValue, bundle: Bundle.main)
}

extension UIViewController{
    func showImage(isRemoveNeed: String? = nil,with completion : @escaping ((UIImage?)->())){  //isRemoveNeed - used to remove photo in profile
        
        AppActionSheet.shared.showActionSheet(viewController: self,message: "Choose your picture", buttonOne: "Open Camera", buttonTwo: "Open Gallery",buttonThird: isRemoveNeed == nil ? nil : "Remove Photo")
        imageCompletion = completion
        AppActionSheet.shared.onTapAction = { [weak self] tag in
            guard let self = self else {
                return
            }
            if tag == 0 {
                self.checkCameraPermission(source: .camera)
            }else if tag == 1 {
                self.checkCameraPermission(source: .photoLibrary)
            }else {
                let imageView = UIImageView()
                imageView.image = UIImage(named: "ImagePlaceHolder")
                imageCompletion?(imageView.image)
            }
        }
    }
    
    private func checkCameraPermission(source : UIImagePickerController.SourceType) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch (cameraAuthorizationStatus){
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        if granted {
                            self.chooseImage(with: source)
                        }else {
                           showToast(msg: "Unable to open camera, Check your camera permission")
                        }
                    }
                }
            case .restricted, .denied:
                showToast(msg: "Unable to open camera, Check your camera permission")
            case .authorized:
                self.chooseImage(with: source)
            default:
                showToast(msg: "Unable to open camera, Check your camera permission")
        }
    }
    
    private func chooseImage(with source : UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = source
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension UIViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imageCompletion?(image)
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

@objc protocol AppActionSheetDelegate: class {
    
    func actionSheetDelegate(tag: Int)
    
}

class AppActionSheet: NSObject {
    
    //Singleton class
    static let shared = AppActionSheet()
    
    //Delegate
    weak var delegate: AppActionSheetDelegate?
    
    var onTapAction : ((Int)->Void)?
    
    //Actionsheet with two button dynamic
    func showActionSheet(viewController: UIViewController,message: String? =  nil, buttonOne: String, buttonTwo: String? = nil, buttonThird: String? = nil) {
        
        let actionSheetController = UIAlertController(title: nil, message:message, preferredStyle: .actionSheet)
        
        //Cancel
        let cancelButtonAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelButtonAction)
        
        //Button One
        let buttonOneAction = UIAlertAction(title: buttonOne, style: .default) { action -> Void in
            self.onTapAction?(0)
            self.delegate?.actionSheetDelegate(tag: 0)
        }
        actionSheetController.addAction(buttonOneAction)
        
        if (buttonTwo != nil) {
            //Button Two
            let buttonTwoAction = UIAlertAction(title: buttonTwo, style: .default) { action -> Void in
                self.onTapAction?(1)
                self.delegate?.actionSheetDelegate(tag: 1)
            }
            actionSheetController.addAction(buttonTwoAction)
        }
        
        if (buttonThird != nil) {
            //Button Two
            let buttonThirdAction = UIAlertAction(title: buttonThird, style: .default) { action -> Void in
                self.onTapAction?(2)
                self.delegate?.actionSheetDelegate(tag: 2)
            }
            actionSheetController.addAction(buttonThirdAction)
        }
        
        viewController.present(actionSheetController, animated: true, completion: nil)
    }
}

//MARK:- UINavigationControllerDelegate

extension UIViewController: UINavigationControllerDelegate {
    
}
