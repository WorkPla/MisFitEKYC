//
//  FaceCompareApi.swift
//  MisFitSDK
//
//  Created by Shuvo on 3/2/22.
//

import Foundation
import UIKit

public class FaceCompareApi {
    let hello = "Hello"

    public init() {}

    public func hello(to whom: String) -> String {
        return "Hello \(whom)"
    }
}

extension FaceCompareApi {
//    public func apiMatchCompare(media1: UIImage, fileName1: String, media2: UIImage, fileName2: String, completion : @escaping (JSON?) -> ()) {
//        let url = URL(string: "\(baseUrl)api/v1/face/compare")!
//        let headers: HTTPHeaders = [
//            "Authorization": "eyJhbGciOiJSUzI1NiIsInppcCI6IkRFRiJ9.eJxtzT0LwjAQgOH_cnMRpR-UTCpUcEmgdMyStlcIXhpJGhBK_7sxXRScDp7j3lsBX09gp6rI86Kuj2UGPvTAYJWgRwmsrPJMQvDoZmUwggSj_aQXCdGnQMT_OBql6QvP-zgM1qQ92eGBn_ykyGOEUXvV0y_ZGJlT5HrvLlzwdOos7e9aIboki0aX5NY2jYQNtjdmLUQf.B4Cft0cKwa_ADD3BvgQLv-7v7cLkQTLOz-4tS829l-OPnrA4akJM9aV05o904usQ9F5kGrFUc4UxyiKdOV25fWUZHX-7UfX7nNcYn-qfJsupOWnlbwp9ljcKweYYki_2diifS8DUrXNxva2wJ-MhCbFjo6Jl3hh3fB8m15K9WvmRFWLTgCAKelSOXLNo8JPOjLAML1fgZRmQe4KViHlO9Ce8mUP1ZCDSFcXQthS9D0G69RLHuC7AVzZHX2twsM_IvNkmIMmKzuVK9CAp-EizX6tqv8Ljc8Bw8xuR3Ceam4N4g6DXhE-fx-efouYd8FRtSEWnIPrlvqFC2UZ_HSNeuQ"
//        ]
//
//        let imageData:NSData = media1.jpegData(compressionQuality: 0.1)! as NSData
//        let imageData2:NSData = media2.jpegData(compressionQuality: 0.1)! as NSData
//        let parameters = [
//            "image1" : imageData.base64EncodedString(options: []),
//            "image2" : imageData2.base64EncodedString(options: [])
//        ] as [String : Any]
//
//        DispatchQueue.main.async {
//            AF.request(
//                url,
//                method: .post,
//                parameters: parameters,
//                encoding: URLEncoding.default,
//                headers: headers
//                ).response {
//                (response) in
//
//                switch response.result {
//
//                    case .success(let json):
//                        let jsonData = JSON(json as Any)
//                        guard let statusCode = response.response?.statusCode else { return }
//                        if(statusCode == 200) {
//                            completion(jsonData)
//                        }
//                        else {
//                            completion(nil)
//                        }
//
//                case .failure(_):
//                        completion(nil)
//
//                }
//            }
//        }
//    }
    
    public func apiRequestForMatchCompare(media1: UIImage, fileName1: String, media2: UIImage, fileName2: String, completion : @escaping (Any?) -> ()) {
        let Url = "\(baseUrl)api/v1/face/compare"
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
        request.setValue("Authorization", forHTTPHeaderField: "eyJhbGciOiJSUzI1NiIsInppcCI6IkRFRiJ9.eJxtzT0LwjAQgOH_cnMRpR-UTCpUcEmgdMyStlcIXhpJGhBK_7sxXRScDp7j3lsBX09gp6rI86Kuj2UGPvTAYJWgRwmsrPJMQvDoZmUwggSj_aQXCdGnQMT_OBql6QvP-zgM1qQ92eGBn_ykyGOEUXvV0y_ZGJlT5HrvLlzwdOos7e9aIboki0aX5NY2jYQNtjdmLUQf.B4Cft0cKwa_ADD3BvgQLv-7v7cLkQTLOz-4tS829l-OPnrA4akJM9aV05o904usQ9F5kGrFUc4UxyiKdOV25fWUZHX-7UfX7nNcYn-qfJsupOWnlbwp9ljcKweYYki_2diifS8DUrXNxva2wJ-MhCbFjo6Jl3hh3fB8m15K9WvmRFWLTgCAKelSOXLNo8JPOjLAML1fgZRmQe4KViHlO9Ce8mUP1ZCDSFcXQthS9D0G69RLHuC7AVzZHX2twsM_IvNkmIMmKzuVK9CAp-EizX6tqv8Ljc8Bw8xuR3Ceam4N4g6DXhE-fx-efouYd8FRtSEWnIPrlvqFC2UZ_HSNeuQ")
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

