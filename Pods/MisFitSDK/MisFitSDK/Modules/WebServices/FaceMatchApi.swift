//
//  NIDProcessModule.swift
//  MisFitSDK
//
//  Created by Shuvo on 12/19/21.
//

//import Foundation
//import UIKit
//
//public class FaceMatchApi {
//    let hello = "Hello"
//
//    public init() {}
//
//    public func hello(to whom: String) -> String {
//        return "Hello \(whom)"
//    }
//}
//
//extension FaceMatchApi {
//    public func apiMatchFace(url : URL, media1: UIImage, fileName1: String, media2: UIImage, fileName2: String, completion : @escaping (Double) -> ()) {
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
//                        fileName: "NRC.jpeg", mimeType: "image/jpeg"
//                    )
//                    multipartFormData.append(media2.jpegData(
//                        compressionQuality: 0.1)!,
//                        withName: fileName2, // key name
//                        fileName: "SELFI.jpeg", mimeType: "image/jpeg"
//                    )
//                },
//                to: url,
//                method: .post,
//                headers: headers
//            )
//            .response { (response) in
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
//    
//    func apiRequestForMatchFace(url : URL, media1: UIImage, fileName1: String, media2: UIImage, fileName2: String, completion : @escaping (Any?) -> ()) {
//            // your image from Image picker, as of now I am picking image from the bundle
//        let image1 = media1
//        let imageData1 = image1.jpegData(compressionQuality: 0.7)
//
//        let image2 = media2
//        let imageData2 = image2.jpegData(compressionQuality: 0.7)
//
//        var urlRequest = URLRequest(url: url)
//
//        urlRequest.httpMethod = "post"
//        let bodyBoundary = "--------------------------\(UUID().uuidString)"
//        urlRequest.addValue("multipart/form-data; boundary=\(bodyBoundary)", forHTTPHeaderField: "Content-Type")
//
//        //attachmentKey is the api parameter name for your image do ask the API developer for this
//        // file name is the name which you want to give to the file
//        var requestData = createRequestBody(imageData: imageData1!, boundary: bodyBoundary, attachmentKey: "NRC", fileName: "NRC.jpeg")
//        requestData.append(createRequestBody(imageData: imageData2!, boundary: bodyBoundary, attachmentKey: "SELFI", fileName: "SELFI.jpeg"))
//
//        urlRequest.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
//        urlRequest.httpBody = requestData
//
//        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//                if let data = data {
//                    print(data)
//                }
//
//            }.resume()
//        }
//
//        func createRequestBody(imageData: Data, boundary: String, attachmentKey: String, fileName: String) -> Data{
//            let lineBreak = "\r\n"
//            var requestBody = Data()
//
//            requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
//            requestBody.append("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)" .data(using: .utf8)!)
//            requestBody.append("Content-Type: image/jpeg \(lineBreak + lineBreak)" .data(using: .utf8)!) // you can change the type accordingly if you want to
//            requestBody.append(imageData)
//            requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
//
//            return requestBody
//        }
//}
