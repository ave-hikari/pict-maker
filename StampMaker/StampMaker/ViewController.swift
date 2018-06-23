

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // MARK:lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // ライブラリボタンをタップ
    @IBAction func tapLibraryButton(sender: AnyObject) {
        //イメージを取ってくるのをライブラリと指定する
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            //ライブラリから選択後、正方形にトリミングする
            controller.allowsEditing = true
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    // カメラボタンをタップするとカメラを起動させる
    @IBAction func tapCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            //カメラで写真を撮った後、正方形にトリミングする
            controller.allowsEditing = true
            controller.sourceType = UIImagePickerControllerSourceType.camera
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    // 写真を選択した時に呼ばれる
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // 遷移するViewを定義
        let drawViewController:DrawViewController = DrawViewController(nibName: "DrawViewController", bundle: Bundle.mainBundle)
        //選択時トリミングした画像を使用する
        if info[UIImagePickerControllerEditedImage] != nil {
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            drawViewController.tempImage = image
            print(image)
        }
        picker.dismiss(animated: true, completion: nil)
        
        self.navigationController?.pushViewController(drawViewController, animated: true)

    }
}


