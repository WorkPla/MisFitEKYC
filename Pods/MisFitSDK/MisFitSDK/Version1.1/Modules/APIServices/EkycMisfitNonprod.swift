//
//  EkycMisfitNonprod.swift
//  MisFitSDK
//
//  Created by Shuvo on 7/5/22.
//

import Foundation
import UIKit
import Alamofire
import Photos

public class EkycMisfitNonprod {
    let base_url = "https://nonprodocr.wavemoney.io/"
    var EkycMisfit_token = String()
    public init(token: String) {
        self.EkycMisfit_token = token
    }
}
extension EkycMisfitNonprod {
    public func get_cardinfo(media1: String, cbm : Bool, filter : Bool, source : String, check_age : Bool, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/ocr/mm_id_card"
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = [
            "image" : media1,
            "cbm": cbm,
            "filter": filter,
            "source": source,
            "check_age": check_age
        ] as [String : Any]
        //print(parameterDictionary)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(EkycMisfit_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                completion(error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            completion(json)
                        } catch {
                            completion(error)
                        }
                    }
                }
                else {
                    completion(self.processStatusCode(statusCode:httpResponse.statusCode))
                }
            }
        }.resume()
    }
    
    private func processStatusCode(statusCode: Int) -> String {
        return statusCode == 400 ? "\(statusCode) -> Image parameter not present." :
        statusCode == 401 ? "\(statusCode) -> Wrong auth token." :
        statusCode == 403 ? "\(statusCode) -> Age < 18" :
        statusCode == 406 ? "\(statusCode) -> Invalid image." :
        statusCode == 417 ? "\(statusCode) -> Length of digit number of nrc_id not equal to 6." :
        statusCode == 418 ? "\(statusCode) -> Region code of nrc_id not in between 1 to 14." :
        statusCode == 419 ? "\(statusCode) -> township code of nrc_id not matches the region." :
        statusCode == 422 ? "\(statusCode) -> Unprocurable entity" :
        statusCode == 500 ? "\(statusCode) -> Other exceptions except invalid image." :
        statusCode == 502 ? "\(statusCode) -> Bad gateway/server may be down" : "Status Code = \(statusCode)"
    }
}

extension EkycMisfitNonprod {
    public func get_cardside(media1: String, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/nrc/detect"
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = [
            "image" : media1
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(EkycMisfit_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                completion(error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            completion(json)
                        } catch {
                            completion(error)
                        }
                    }
                }
                else {
                    completion(self.processStatusCode(statusCode:httpResponse.statusCode))
                }
            }
        }.resume()
    }
}

extension EkycMisfitNonprod {
    public func get_passportdetails(media1: String, check_expiry: Bool, check_age: Bool, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/ocr/passport"
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = [
            "image" : media1,
            "check_expiry": check_expiry,
            "check_age": check_age
        ] as [String : Any]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(EkycMisfit_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                completion(error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            completion(json)
                        } catch {
                            completion(error)
                        }
                    }
                }
                else {
                    completion(self.processStatusCode(statusCode:httpResponse.statusCode))
                }
            }
        }.resume()
    }
}

extension EkycMisfitNonprod {
    public func get_face_comparison(File1 media1: Any?, File2 media2: Any?, File2Tpe image2_type: String, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/faces/compare"
        guard let serviceUrl = URL(string: Url) else { return }
        
        var media01 = UIImage()
        var media02 = UIImage()
        
        var marker1 = false
        var marker2 = false
        
        if media1 as? UIImage != nil {
            print("media1 -> image")
            media01 = media1 as! UIImage
        }
        else if media1 as? PHLivePhoto != nil {
            let livePhoto = media1 as! PHLivePhoto
            
            let resources = PHAssetResource.assetResources(for: livePhoto)
            let photo = resources.first(where: { $0.type == .photo })!
            let imageData = NSMutableData()
            
            PHAssetResourceManager.default().requestData(for: photo, options: nil, dataReceivedHandler: { data in
                imageData.append(data)
                print("live photo ......")
                media01 = UIImage(data: imageData as Data)!
            }, completionHandler: { error in
                _ = UIImage(data: imageData as Data)!
            })
        }
        else {
            marker1 = true
            print("media1 -> video \(String(describing: media1))")
        }
        
        if media2 as? UIImage != nil {
            print("media2 -> image")
            media02 = media2 as! UIImage
        }
        else if media2 as? PHLivePhoto != nil {
            let livePhoto = media2 as! PHLivePhoto
            
            let resources = PHAssetResource.assetResources(for: livePhoto)
            let photo = resources.first(where: { $0.type == .photo })!
            let imageData = NSMutableData()
            
            PHAssetResourceManager.default().requestData(for: photo, options: nil, dataReceivedHandler: { data in
                imageData.append(data)
                print("live photo ......")
                media02 = UIImage(data: imageData as Data)!
            }, completionHandler: { error in
                _ = UIImage(data: imageData as Data)!
            })
        }
        else {
            marker2 = true
            print("media2 -> video \(String(describing: media1))")
        }
       
        let headers: HTTPHeaders = [
            "Authorization": EkycMisfit_token
        ]
        // local video upload possible only by data or base64
        // https://stackoverflow.com/questions/49649315/uploading-video-using-url-swift-alamofire
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(Data(image2_type.utf8), withName: "image2_type")
                if marker1 {
                    let dat = media1 as! Data
                    multipartFormData.append(dat, withName: "image1", fileName: "image.mp4", mimeType: "image/mp4")
                }
                else {
                    multipartFormData.append(media01.jpegData(compressionQuality: 0.1)!,
                        withName: "image1", // key name
                        fileName: "NRC.jpeg", mimeType: "image/jpeg"
                    )
                }
                
                if marker2 {
                    let dat = media2 as! Data
                    multipartFormData.append(dat, withName: "image2", fileName: "image.mp4", mimeType: "image/mp4")
                }
                else {
                    multipartFormData.append(media02.jpegData(compressionQuality: 0.1)!,
                        withName: "image2", // key name
                        fileName: "image2.jpeg", mimeType: "image2/jpeg"
                    )
                }
            },
            to: serviceUrl,
            method: .post,
            headers: headers,
            encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        //print("printing response  - > \(response.result)")
                        //debugPrint(response)
                        if response.result.isSuccess {
                            //do anything you want
                            completion(response.result.value)
                        } else if response.result.isFailure {
                            //handle error case
                            completion(response.result.value)
                        }
                    }
                    upload.uploadProgress(closure: {
                        progress in
                        //print(progress.fractionCompleted)
                    })
                    case .failure(let encodingError):
                        //print(encodingError)
                        completion(encodingError)
                    }
                })
    }
    
    public func get_face_comparison(String1 media1: String, String2 media2: String, Image2Type image2_type: String, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/faces/compare"
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = [
            "image1" : media1,
            "image2" : media2
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(EkycMisfit_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                completion(error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            completion(json)
                        } catch {
                            completion(error)
                        }
                    }
                }
                else {
                    completion(self.processStatusCode(statusCode:httpResponse.statusCode))
                }
            }
        }.resume()
    }
}

extension EkycMisfitNonprod {
    public func get_face_detect(File media1:Any, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/faces/detect"
        guard let serviceUrl = URL(string: Url) else { return }
        
        var media01 = UIImage()
        var marker1 = false
        
        if media1 as? UIImage != nil {
            print("media1 -> image")
            media01 = media1 as! UIImage
        }
        else if media1 as? PHLivePhoto != nil {
            let livePhoto = media1 as! PHLivePhoto
            
            let resources = PHAssetResource.assetResources(for: livePhoto)
            let photo = resources.first(where: { $0.type == .photo })!
            let imageData = NSMutableData()
            
            PHAssetResourceManager.default().requestData(for: photo, options: nil, dataReceivedHandler: { data in
                imageData.append(data)
                media01 = UIImage(data: imageData as Data)!
            }, completionHandler: { error in
                _ = UIImage(data: imageData as Data)!
            })
        }
        else {
            marker1 = true
            print("media1 -> video \(String(describing: media1))")
        }
       
        let headers: HTTPHeaders = [
            "Authorization": EkycMisfit_token
        ]
        // local video upload possible only by data or base64
        // https://stackoverflow.com/questions/49649315/uploading-video-using-url-swift-alamofire
        // https://github.com/Alamofire/Alamofire/blob/master/Documentation/Alamofire%204.0%20Migration%20Guide.md
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if marker1 {
                    let dat = media1 as! Data
                    multipartFormData.append(dat, withName: "image", fileName: "image.mp4", mimeType: "image/mp4")
                }
                else {
                    multipartFormData.append(media01.jpegData(compressionQuality: 0.1)!,
                        withName: "image", // key name
                        fileName: "NRC.jpeg", mimeType: "image/jpeg"
                    )
                }
            },
            //usingThreshold: .max,
            to: serviceUrl,
            method: .post,
            headers: headers,
            encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        //print("printing response  - > \(response.result.value)")
                        //debugPrint(response)
                        if response.result.isSuccess {
                         //do anything you want
                            //print("success")
                            completion(response.result.value)
                        } else if response.result.isFailure {
                         //handle error case
                            //print("isFailure \(response.response?.statusCode)")
                            completion(response.result.value)
                        }
                    }
                    upload.uploadProgress(closure: {
                        progress in
                        //print(progress.fractionCompleted)
                    })
                case .failure(let encodingError):
                    //print(encodingError)
                    completion(encodingError)
                }
            })
    }
    public func get_face_detect(String media1:String, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)api/v1/faces/detect"
        guard let serviceUrl = URL(string: Url) else { return }
        //let imageData:NSData = media1!.jpegData(compressionQuality: 0.1)! as NSData
        let parameterDictionary = [
            "image" : media1
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(EkycMisfit_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                completion(error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            completion(json)
                        } catch {
                            completion(error)
                        }
                    }
                }
                else {
                    completion(self.processStatusCode(statusCode:httpResponse.statusCode))
                }
            }
        }.resume()
    }
}

extension EkycMisfitNonprod {
    public func get_cardinfo_with_face(media1: String, cbm : Bool, filter : Bool, source : String, check_age : Bool, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)/api/v1/ocr/mm_id_face_detect"
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = [
            "image" : media1,
            "cbm": cbm,
            "filter": filter,
            "source": source,
            "check_age": check_age
        ] as [String : Any]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(EkycMisfit_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                completion(error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            completion(json)
                        } catch {
                            completion(error)
                        }
                    }
                }
                else {
                    completion(self.processStatusCode(statusCode:httpResponse.statusCode))
                }
            }
        }.resume()
    }
}
extension EkycMisfitNonprod {
    public func get_passportinfo_with_face(media1: String, source : String, check_age : Bool, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)/api/v1/ocr/passport_face_detect"
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = [
            "image" : media1,
            "source": source,
            "check_age": check_age
        ] as [String : Any]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(EkycMisfit_token, forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print("Error \(String(describing: error))")
                completion(error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            completion(json)
                        } catch {
                            completion(error)
                        }
                    }
                }
                else {
                    completion(self.processStatusCode(statusCode:httpResponse.statusCode))
                }
            }
        }.resume()
    }
}

