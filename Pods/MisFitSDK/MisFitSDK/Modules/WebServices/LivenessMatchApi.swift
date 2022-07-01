//
//  LivenessMatchApi.swift
//  MisFitSDK
//
//  Created by Shuvo on 1/5/22.
//

//import Foundation
//import UIKit
//
//public class LivenessMatchApi {
//    public init() {}
//    public func apiLivenessMatchFace(url : URL, media1: UIImage, fileName1: String, media2: UIImage, fileName2: String, completion : @escaping (JSON?) -> ()) -> ()) {
//        let livenesAPI = FaceLivenessApi()
//        livenesAPI.apiLivenessFace(url: url, media1: media1, fileName1: fileName1) { (confidence0) in
//
//            livenesAPI.apiLivenessFace(url: url, media1: media2, fileName1: fileName2) { (confidence1) in
//
//                let matchAPI = FaceMatchApi()
//                matchAPI.apiMatchFace(url: url, media1: media1, fileName1: fileName1, media2: media2, fileName2: fileName2) { (confidence2) in
//
//                    completion(confidence0, confidence1, confidence2)
//                }
//            }
//        }
//    }
//}
