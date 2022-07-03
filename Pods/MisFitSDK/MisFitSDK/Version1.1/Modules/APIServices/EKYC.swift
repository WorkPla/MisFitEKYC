//
//  EKYC.swift
//  MisFitSDK
//
//  Created by Shuvo on 7/2/22.
//

import Foundation
import UIKit

//let base_url = "https://prodocr.wavemoney.io/"
//let ekyc_token = "Token eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2NTYzMzEyMDV9.JMsj1JgSeQNe47LFJ7xYJHyGsm2ZmeMGMZ9ZC1DvYKk"

let base_url = "https://nonprodocr.wavemoney.io/"
let ekyc_token = "Token eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2NTQxNTY0NjB9.KyDGBi4yB-QvIjC8PjliDDVlM0add8rG90RoIn0hfnM"
public class EKYC {
    public init() {}
}
extension EKYC {
    public func get_cardinfo(media1: UIImage?, cbm : Bool, filter : Bool, source : String, check_age : Bool, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/ocr/mm_id_card"
        guard let serviceUrl = URL(string: Url) else { return }
        let imageData:NSData = media1!.jpegData(compressionQuality: 0.1)! as NSData
        let parameterDictionary = [
            "image" : imageData.base64EncodedString(options: []),
            "cbm": cbm,
            "filter": filter,
            "source": source,
            "check_age": check_age
        ] as [String : Any]
        //print(parameterDictionary)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ekyc_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            print("error -> \(String(describing: error))")
            if response != nil {
                //print(response!)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(json)
                } catch {
                    completion(error)
                }
            }
        }.resume()
    }
}

extension EKYC {
    public func get_cardside(media1: UIImage?, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/nrc/detect"
        guard let serviceUrl = URL(string: Url) else { return }
        let imageData:NSData = media1!.jpegData(compressionQuality: 0.1)! as NSData
        let parameterDictionary = [
            "image" : imageData.base64EncodedString(options: [])
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ekyc_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {
                //print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(json)
                } catch {
                    completion(error)
                }
            }
        }.resume()
    }
}

extension EKYC {
    public func get_passportdetails(media1: UIImage?, check_expiry: Bool, check_age: Bool, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/ocr/passport"
        guard let serviceUrl = URL(string: Url) else { return }
        let imageData:NSData = media1!.jpegData(compressionQuality: 0.1)! as NSData
        let parameterDictionary = [
            "image" : imageData.base64EncodedString(options: []),
            "check_expiry": check_expiry,
            "check_age": check_age
        ] as [String : Any]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ekyc_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {
                //print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(json)
                } catch {
                    completion(error)
                }
            }
        }.resume()
    }
}

extension EKYC {
    public func get_face_comparison(media1: UIImage, media2: UIImage, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/faces/compare"
        guard let serviceUrl = URL(string: Url) else { return }
        let imageData:NSData = media1.jpegData(compressionQuality: 0.1)! as NSData
        let imageData2:NSData = media2.jpegData(compressionQuality: 0.1)! as NSData
        let parameterDictionary = [
            "image1" : imageData.base64EncodedString(options: []),
            "image2" : imageData2.base64EncodedString(options: [])
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ekyc_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {
                //print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(json)
                } catch {
                    completion(error)
                }
            }
        }.resume()
    }
}

extension EKYC {
    public func get_face_detect(media1: UIImage?, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/faces/detect"
        guard let serviceUrl = URL(string: Url) else { return }
        let imageData:NSData = media1!.jpegData(compressionQuality: 0.1)! as NSData
        let parameterDictionary = [
            "image" : imageData.base64EncodedString(options: [])
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ekyc_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if response != nil {
                //print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(json)
                } catch {
                    completion(error)
                }
            }
        }.resume()
    }
}
