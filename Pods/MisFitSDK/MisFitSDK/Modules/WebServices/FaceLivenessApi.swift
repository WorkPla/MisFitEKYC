//
//  FaceLivenessApi.swift
//  MisFitSDK
//
//  Created by Shuvo on 1/3/22.
//

//import Foundation
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//public class FaceLivenessApi {
//    public init() {}
//}
//
//extension FaceLivenessApi {
//    public func apiLivenessFace(url : URL, media1: UIImage, fileName1: String, completion : @escaping (Double) -> ()) {
//        let headers: HTTPHeaders = [
//            "Authorization": "eyJhbGciOiJSUzI1NiIsInppcCI6IkRFRiJ9.eJxtzT0LwjAQgOH_cnMRpR-UTCpUcEmgdMyStlcIXhpJGhBK_7sxXRScDp7j3lsBX09gp6rI86Kuj2UGPvTAYJWgRwmsrPJMQvDoZmUwggSj_aQXCdGnQMT_OBql6QvP-zgM1qQ92eGBn_ykyGOEUXvV0y_ZGJlT5HrvLlzwdOos7e9aIboki0aX5NY2jYQNtjdmLUQf.B4Cft0cKwa_ADD3BvgQLv-7v7cLkQTLOz-4tS829l-OPnrA4akJM9aV05o904usQ9F5kGrFUc4UxyiKdOV25fWUZHX-7UfX7nNcYn-qfJsupOWnlbwp9ljcKweYYki_2diifS8DUrXNxva2wJ-MhCbFjo6Jl3hh3fB8m15K9WvmRFWLTgCAKelSOXLNo8JPOjLAML1fgZRmQe4KViHlO9Ce8mUP1ZCDSFcXQthS9D0G69RLHuC7AVzZHX2twsM_IvNkmIMmKzuVK9CAp-EizX6tqv8Ljc8Bw8xuR3Ceam4N4g6DXhE-fx-efouYd8FRtSEWnIPrlvqFC2UZ_HSNeuQ"
//        ]
//
//        DispatchQueue.main.async {
//            AF.upload(
//                multipartFormData: { multipartFormData in
//                    multipartFormData.append(media1.jpegData(
//                        compressionQuality: 0.1)!,
//                        withName: fileName1, // key name
//                        fileName: "aimage.jpeg", mimeType: "image/jpeg"
//                    )
//                },
//                to: url,
//                method: .post,
//                headers: headers
//            )
//            .responseJSON { (response) in
//
//                switch response.result {
//                case .success(let json):
//                    let jsonData = JSON(json as Any)
//                    guard let statusCode = response.response?.statusCode else { return }
//                    if statusCode == 200 {
//                        completion(jsonData["data"]["confidence"].doubleValue)
//                    }
//                    else {
//                        completion(0.0)
//                    }
//
//                case .failure(_):
//                    completion(0.0)
//                }
//            }
//        }
//    }
//}
