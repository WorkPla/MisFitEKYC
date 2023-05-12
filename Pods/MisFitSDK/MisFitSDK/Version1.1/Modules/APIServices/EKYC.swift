//
//  EKYC.swift
//  MisFitSDK
//
//  Created by Shuvo on 9/19/22.
//

import Foundation
import UIKit
import Alamofire
import Photos

public class EKYC {
    private let unknownErrorCode = 502
    private var base_url = ""
    private var EkycMisfit_token = ""
    
    init(url : String, token : String) {
        self.base_url = url
        self.EkycMisfit_token = token
    }
    
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
            if error != nil && (response as? HTTPURLResponse)?.statusCode != 401 && (response as? HTTPURLResponse)?.statusCode != 500  {
                print("Error \(String(describing: error))")
                completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode, response: json))
                } catch {
                    let json = String(bytes: data, encoding: String.Encoding.utf8)
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode == 401 ? 401 : httpResponse!.statusCode == 500 ? 500 : self.unknownErrorCode, response: json ?? ""))
                }
            }
        }.resume()
    }
    
    public func checkStatus(completion : @escaping (Any?) -> ()) {
        let Url = "https://httpstat.us/500"
        guard let serviceUrl = URL(string: Url) else { return }
        
        //print(parameterDictionary)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        //equest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue(EkycMisfit_token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil && (response as? HTTPURLResponse)?.statusCode != 401 && (response as? HTTPURLResponse)?.statusCode != 500  {
                print("Error \(String(describing: error))")
                completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode, response: json))
                } catch {
                    let json = String(bytes: data, encoding: String.Encoding.utf8)
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode == 401 ? 401 : httpResponse!.statusCode == 500 ? 500 : self.unknownErrorCode, response: json ?? ""))
                }
            }
        }.resume()
    }
 
    private func processStatusCode(statusCode: Int, response : Any) -> Any {
   
        if statusCode == 200 {
            return response
        }
        else if statusCode == 401 {
            let returnObject: Any  = [
                 "success": false,
                 "message": response,
                 "status_code": 401
            ]
            return returnObject
        }
        else if statusCode == 500 {
            let returnObject: Any  = [
                 "success": false,
                 "message": "Other exceptions except invalid image",
                 "status_code": 500
            ]
            return returnObject
        }
        else if statusCode == 502 {
            let returnObject: Any  = [
                 "success": false,
                 "message": "Bad gateway/server may be down",
                 "status_code": 502
            ]
            return returnObject
        }
        else {
            return response
        }
    }
}

extension EKYC {
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
            if error != nil && (response as? HTTPURLResponse)?.statusCode != 401 && (response as? HTTPURLResponse)?.statusCode != 500  {
                print("Error \(String(describing: error))")
                completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode, response: json))
                } catch {
                    let json = String(bytes: data, encoding: String.Encoding.utf8)
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode == 401 ? 401 : httpResponse!.statusCode == 500 ? 500 : self.unknownErrorCode, response: json ?? ""))
                }
            }
        }.resume()
    }
}

extension EKYC {
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
            if error != nil && (response as? HTTPURLResponse)?.statusCode != 401 && (response as? HTTPURLResponse)?.statusCode != 500  {
                print("Error \(String(describing: error))")
                completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode, response: json))
                } catch {
                    let json = String(bytes: data, encoding: String.Encoding.utf8)
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode == 401 ? 401 : httpResponse!.statusCode == 500 ? 500 : self.unknownErrorCode, response: json ?? ""))
                }
            }
        }.resume()
    }
}

extension EKYC {
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
                        let httpResponse = response.response?.statusCode
                        if response.result.isSuccess {
                            //do anything you want
                            completion(self.processStatusCode(statusCode:httpResponse!, response: response.result.value!))
                        } else if response.result.isFailure {
                            //handle error case
                            print("isFailure \(String(describing: response.response?.statusCode))")
                            completion(self.processStatusCode(statusCode:response.response?.statusCode == 401 ? 401 : response.response?.statusCode == 500 ? 500 : self.unknownErrorCode, response: response.result.value ?? "nil"))
                        }
                    }
                    upload.uploadProgress(closure: {
                        progress in
                        //print(progress.fractionCompleted)
                    })
                    case .failure(let encodingError):
                        print(encodingError)
                        completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                        //completion(encodingError)
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
            if error != nil && (response as? HTTPURLResponse)?.statusCode != 401 && (response as? HTTPURLResponse)?.statusCode != 500  {
                print("Error \(String(describing: error))")
                completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode, response: json))
                } catch {
                    let json = String(bytes: data, encoding: String.Encoding.utf8)
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode == 401 ? 401 : httpResponse!.statusCode == 500 ? 500 : self.unknownErrorCode, response: json ?? ""))
                }
            }
        }.resume()
    }
}

extension EKYC {
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
                        let httpResponse = response.response?.statusCode
                        if response.result.isSuccess {
                         //do anything you want
                            //print("success")
                           
                            completion(self.processStatusCode(statusCode:httpResponse!, response: response.result.value!))
                        } else if response.result.isFailure {
                         //handle error case
                            print("isFailure \(String(describing: response.response?.statusCode))")
                            completion(self.processStatusCode(statusCode:response.response?.statusCode == 401 ? 401 : response.response?.statusCode == 500 ? 500 : self.unknownErrorCode, response: response.result.value ?? "nil"))
                        }
                    }
                    upload.uploadProgress(closure: {
                        progress in
                        //print(progress.fractionCompleted)
                    })
                case .failure(let encodingError):
                    print(encodingError)
                    completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
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
            if error != nil && (response as? HTTPURLResponse)?.statusCode != 401 && (response as? HTTPURLResponse)?.statusCode != 500  {
                print("Error \(String(describing: error))")
                completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode, response: json))
                } catch {
                    let json = String(bytes: data, encoding: String.Encoding.utf8)
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode == 401 ? 401 : httpResponse!.statusCode == 500 ? 500 : self.unknownErrorCode, response: json ?? ""))
                }
            }
        }.resume()
    }
}

extension EKYC {
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
            if error != nil && (response as? HTTPURLResponse)?.statusCode != 401 && (response as? HTTPURLResponse)?.statusCode != 500  {
                print("Error \(String(describing: error))")
                completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode, response: json))
                } catch {
                    let json = String(bytes: data, encoding: String.Encoding.utf8)
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode == 401 ? 401 : httpResponse!.statusCode == 500 ? 500 : self.unknownErrorCode, response: json ?? ""))
                }
            }
        }.resume()
    }
}
extension EKYC {
    public func get_passportinfo_with_face(media1: String, source : String, check_expiry: Bool, check_age : Bool, completion : @escaping (Any?) -> ()) {
        let Url = "\(base_url)/api/v1/ocr/passport_face_detect"
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = [
            "image" : media1,
            "source": source,
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
            if error != nil && (response as? HTTPURLResponse)?.statusCode != 401 && (response as? HTTPURLResponse)?.statusCode != 500  {
                print("Error \(String(describing: error))")
                completion(self.processStatusCode(statusCode:self.unknownErrorCode, response: ""))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode, response: json))
                } catch {
                    let json = String(bytes: data, encoding: String.Encoding.utf8)
                    completion(self.processStatusCode(statusCode:httpResponse!.statusCode == 401 ? 401 : httpResponse!.statusCode == 500 ? 500 : self.unknownErrorCode, response: json ?? ""))
                }
            }
        }.resume()
    }
}


