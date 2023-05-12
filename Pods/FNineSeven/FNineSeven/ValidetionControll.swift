//
//  ValidetionControll.swift
//  FNineSeven
//
//  Created by Shuvo on 6/8/21.
//

import Foundation
import UIKit

public class ValidationChecker {
    private let hello = "Hello"
    public init() {}
    
    public func validatePhoneNo(str : String) -> Bool {
        if str.count != 11 && str.count != 14 {
            return false
        }
        return str.validPhoneNumber
    }
    
    public func validateEmail(emailAddress : String) -> Bool {
        if emailAddress.count < 12 {
            return false
        }
        return emailAddress.isEmail
    }
}

extension String {
    // mobile number validetion
    public var validPhoneNumber: Bool {
            let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
            guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
            if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
                return match == self
            } else {
                return false
            }
        }
    
    // mobile number validetion
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }

    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }

    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //validate Password
    //Formula
    /*
     Minimum 8 characters at least 1 Alphabet and 1 Number:
     */
    // formula link: https://stackoverflow.com/questions/39284607/how-to-implement-a-regex-for-password-validation-in-swift
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil) {

                if(self.count>=6 && self.count<=20) {
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
}
