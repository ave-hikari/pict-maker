
import UIKit

//汎用的なクラスメソッドはここに書く
class AppUtility {
    
    //16進数のカラーコードをUIColorで指定し返却する
    //https://gist.github.com/arshad/de147c42d7b3063ef7bc
    static func colorWithHexString (hex:String) -> UIColor {
        
        let cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
//        let cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if ((cString as String).characters.count != 6) {
            return UIColor.init(red: 230/255, green: 255/255, blue: 230/255, alpha: 90/100)
//            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substring(with: NSRange(location: 0, length: 2))
        let gString = (cString as NSString).substring(with: NSRange(location: 2, length: 2))
        let bString = (cString as NSString).substring(with: NSRange(location: 4, length: 2))
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(
            red: CGFloat(Float(r) / 255.0),
            green: CGFloat(Float(g) / 255.0),
            blue: CGFloat(Float(b) / 255.0),
            alpha: CGFloat(Float(1.0))
        )
    }
}

extension UIColor {
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
