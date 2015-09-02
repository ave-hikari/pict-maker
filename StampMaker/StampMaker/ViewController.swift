

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var newImage: UIImage!
    
    @IBOutlet weak var addText: UITextField!
    
    var label1: UILabel!
    var stampLabel: UILabel!
    let TAG_LABEL1 = 1
    
    var stampImageView: UIImageView!
    
    // MARK:lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addText.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:IBAction
    
    @IBAction func tapLibBtn(sender: AnyObject) {
        println(__FUNCTION__)
        self.pickImageFromLibrary()
    }
    
    @IBAction func tapAddTextBtn(sender: AnyObject) {
        println(__FUNCTION__)
        let tempImage = self.drawText(mainImage.image!, addText: addText.text)
        mainImage.image = tempImage
    }
    
    @IBAction func tapSaveBtn(sender: AnyObject) {
        println(__FUNCTION__)
        UIImageWriteToSavedPhotosAlbum(mainImage.image, nil, nil, nil)
        
        let alert = UIAlertController(title: nil, message: "画像を保存しました", preferredStyle: .Alert)
        self.presentViewController(alert, animated: true, completion: { () -> Void in
        alert.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    // ライブラリから写真を選択する
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    // 写真を選択した時に呼ばれる
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            mainImage.image = image
            println(image)
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController {
    func drawText(image:UIImage, addText:String) -> UIImage{
        let font = UIFont.boldSystemFontOfSize(100)
        
        let imageRect = CGRectMake(0,0,image.size.width,image.size.height)
        //空のコンテキスト（保存するための画像）を選択した画像と同じサイズで設定
        UIGraphicsBeginImageContext(image.size);
        //そこに描画することを設定
        image.drawInRect(imageRect)
        
        let textRect  = CGRectMake(50, 50, image.size.width - 5, image.size.height - 5)
        self.label1 = UILabel(frame: textRect)
        //self.label1.layer.position = CGPoint(x: image.size.width - 5, y: image.size.height - 5)
        self.label1.userInteractionEnabled = true
        self.label1.tag = self.TAG_LABEL1
        self.view.addSubview(self.label1);
        
        //プロパティつくる
        let textDrawView = UIImageView()
        
        
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        let textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSParagraphStyleAttributeName: textStyle
        ]
        //varの中には何度も入れなおせるが、letには一度きりしか値を入れられない
        addText.drawInRect(textRect, withAttributes: textFontAttributes)
        //コンテキストをイメージとして生成する
        self.newImage = UIGraphicsGetImageFromCurrentImageContext();
        //イメージ生成かんりょう
        UIGraphicsEndImageContext()
        
        return self.newImage
    }
    
    //作ったラベルのタッチを検知する
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        for touch: AnyObject in touches{
            var t: UITouch = touch as! UITouch
            if t.view.tag == self.label1.tag{
                println("touch!!");
                
            }
            //タッチした座標を取得
            let location = touch.locationInView(view)
            //移動したい作成したラベル（仮）
            self.stampLabel = UILabel(frame: CGRectMake(location.x, location.y, 100, 30))
            //新規に貼り付けたいスタンプを用意
            var stampImage: UIImage!
            stampImage = UIImage(named: "wooser.png")
            
            self.stampImageView = UIImageView(image: stampImage)
            self.stampImageView.frame = CGRectMake(location.x - stampImage!.size.width/2, location.y - stampImage!.size.height/2, stampImage!.size.width, stampImage!.size.height)
            self.view.addSubview(stampImageView)
            
//            self.label1.backgroundColor = UIColor.blueColor()
//            self.view.addSubview(stampLabel)
        }
    }
    
    //ドラッグしたときによばれる
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        for touch: AnyObject in touches{
            
        let touchLocation = touch.locationInView(view)
        self.stampImageView.transform = CGAffineTransformMakeTranslation(touchLocation.x - self.stampImageView.center.x, touchLocation.y - self.stampImageView.center.y)
            
        }
    }
}


extension ViewController:UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

