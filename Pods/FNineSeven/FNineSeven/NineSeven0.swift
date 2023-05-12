//
//  NineSeven0.swift
//  FNineSeven
//
//  Created by Shuvo on 4/9/21.
//  https://betterprogramming.pub/ios-build-your-cocoapods-framework-with-an-example-app-from-scratch-fd0f7bdf3f8c

import Foundation
import UIKit

public class NineSeven00 {
    let hello = "Hello"
    private var JWT_KEY = "replace_with_your_strong_jwt_secret_key";
    private var tcost = 2591980
    private var jwtKeyID : String?
    public init() {}
    
    public func setJWTKeyID(jwtKeyID : String?) {
        self.jwtKeyID = jwtKeyID
        UserDefaults.standard.setValue(jwtKeyID, forKey: "jwtKeyID")
    }
    public func getJWTKeyID() -> String? {
        self.jwtKeyID = UserDefaults.standard.string(forKey: "jwtKeyID")
        return self.jwtKeyID
    }
    public func getJWTKey() -> String {
        return self.JWT_KEY
    }
    public func hello(to whom: String) -> String {
        return "Hello \(whom)"
    }
    public func animateuh(view: UIView, centerview: UIView) {
        centerview.isHidden = false
        view.customAnimtationToUnnhide(viewc : view)
    }
    public func animateh(view: UIView, centerview: UIView) {
        centerview.isHidden = true
        view.customAnimtationToHide(viewc : view)
    }
    public func isDigit(phrase : String) -> Bool {
        let num = Int(phrase)
        if num != nil {
            return true
        }
        return false
    }
    public func timeRangeChecker() ->Bool {
        var timeExist:Bool
        let calendar = Calendar.current
        let startTimeComponent = DateComponents(calendar: calendar, hour:10)
        let endTimeComponent   = DateComponents(calendar: calendar, hour: 17, minute: 00)

        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        let startTime    = calendar.date(byAdding: startTimeComponent, to: startOfToday)!
        let endTime      = calendar.date(byAdding: endTimeComponent, to: startOfToday)!

        if startTime <= now && now <= endTime {
            print("between 8 AM and 5:00 PM")
            timeExist = true
        } else {
            print("not between 8 AM and 5:00 PM")
            timeExist = false
        }
        return timeExist
    }
    public func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    public func addLoder(view : UIView) {
        view.activityStartAnimating(activityColor: .white, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6))
    }
    public func removeLoder(view : UIView) {
        view.activityStopAnimating()
    }
    public func timeDiff(currentTime : String, savedTime : String) -> Int {
        if savedTime.count == 0 {
            return 10000
        }
        print("\(currentTime) >> \(savedTime)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        let date0 = dateFormatter.date(from:currentTime)!
        let date1 = dateFormatter.date(from:savedTime)!
        let differenceInSeconds = Int(date0.timeIntervalSince(date1))
        return differenceInSeconds
    }
    public func getCurrentTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        let current_date_time = dateFormatter.string(from: date)
        return current_date_time
    }
    public func ctpts(divToken : String) -> Bool {
        let currentTime = self.getCurrentTime()
        let diff = self.timeDiff(currentTime: currentTime, savedTime: divToken)
        let isValidToken = diff > tcost ? false : true
        print(diff)
        return isValidToken
    }
    // create date for JWT TOKEN: Date(now() + 3sec)
    public func currentTimePlusThreeSec() -> Date {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        let addminutes = date.addingTimeInterval(3*60)
        
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        let after_add_time = dateFormatter.string(from: addminutes)
        UserDefaults.standard.setValue(after_add_time, forKey: "jwtTokenTime")
        
        return addminutes
    }
    public func jwtTokenTime() -> String {
        if UserDefaults.standard.string(forKey: "jwtTokenTime") == nil {
            return ""
        }
        else {
            return UserDefaults.standard.string(forKey: "jwtTokenTime")!
        }
    }
    public func isExperiedToken() {
        let current_date_time = NineSeven00().getCurrentTime()
        let _ : Date = NineSeven00().currentTimePlusThreeSec()
        let after_add_time = NineSeven00().jwtTokenTime()
        print(NineSeven00().timeDiff(currentTime: current_date_time, savedTime: after_add_time))
    }
}

extension UIView {
    func customAnimtationToUnnhide(viewc : UIView) {
        
        UIView.transition(with: viewc, duration: 0.6,
                          options: .transitionFlipFromTop,
                          animations: {
                            viewc.isHidden = false
                      })
    }
    func customAnimtationToHide(viewc : UIView) {
        UIView.transition(with: viewc, duration: 2.4,
                          options: .transitionCurlDown,
                          animations: {
                            viewc.isHidden = true
                      })
    }
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.medium
        } else {
            // Fallback on earlier versions
            activityIndicator.style = UIActivityIndicatorView.Style.white
        }
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)

        self.addSubview(backgroundView)
    }

    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
extension Date {
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }

}
extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
