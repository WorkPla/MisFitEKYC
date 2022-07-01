//
//  NineSeven1.swift
//  FNineSeven
//
//  Created by Shuvo on 4/15/21.
//

import UIKit
import Foundation
import StoreKit
public class NineSeven01 {
    private let hello = "Hello"
    public init() {}
    public func checkboxAnimate(imgvw : UIButton, id:String, pass: String) {
        imgvw.checkboxAnimation {
            
        }
    }
    // create circuler image view
    public func shareApp(link : String, completion: (String) -> ()) {
        completion("https://apps.apple.com/us/app/lifeplus-bangladesh/id1560089833")
    }
    public func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "https://apps.apple.com/us/app/lifeplus-bangladesh/id1560089833") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    public func convertTo12HourClock(timee : String) -> String {
        let dateAsString = timee
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = .current

        let dat = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = .current
        let Date12 = dateFormatter.string(from: dat!)

        return Date12
    }
    public func getAgeFromDOB(date: String) -> (Int,Int,Int) {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/YYYY"
        let dateOfBirth = dateFormater.date(from: date)
        //print(dateOfBirth)
        let calender = Calendar.current

        let dateComponent = calender.dateComponents([.year, .month, .day], from:
        dateOfBirth!, to: Date())

        return (dateComponent.year!, dateComponent.month!, dateComponent.day!)
    }
    public func circularImage(img : UIImageView) {
        img.setRounded()
    }
    public func substringMatch(str : String, pat : String) -> Bool {
        if str.uppercased().contains(pat.uppercased()) {
            return true
        }
        return false
    }
    public func hexxaString(str : String) -> String {
        return str.html2String
    }
    public func buttonTapAnimate(sender : UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = .zero
        pulse.initialVelocity = 0.1
        pulse.damping = 1.0
        sender.layer.add(pulse, forKey: nil)
    }
    public func addShadow(view : UIView) {
        view.layer.applySketchShadow(
            color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16) ,
            alpha: 0.5,
            x: 0,
            y: 3,
            blur: 6,
            spread: 0
        )
    }
    public func addShadow02(view : UIView) {
        view.layer.applySketchShadow(
            color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16) ,
            alpha: 0.5,
            x: 0,
            y: 0,
            blur: 6,
            spread: 0
        )
    }
    public func PlaceApiKeyGoogle() -> String {
        // AIzaSyCTEIcX4uwz37M3q5c95nCNFRNiD2qbERc
        return "AIzaSyCTEIcX4uwz37M3q5c95nCNFRNiD2qbERc"
    }
    //mirazvai: AIzaSyBD-sxKTu1WmDl0pEjS9lia7W3GV80W4dw
    //ios: AIzaSyCTEIcX4uwz37M3q5c95nCNFRNiD2qbERc
}
extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        }
        else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
extension UIButton {
    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}
extension UIImageView {
    func setRounded() {
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
