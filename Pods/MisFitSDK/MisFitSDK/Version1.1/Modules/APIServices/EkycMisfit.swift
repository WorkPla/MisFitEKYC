//
//  EKYC.swift
//  MisFitSDK
//
//  Created by Shuvo on 7/2/22.
//

import Foundation

public class EkycMisfit: EKYC {
    private let unknownErrorCode = 502
    let base_url = "https://prodocr.wavemoney.io/"
    var EkycMisfit_token = String()
    public init(token: String) {
        self.EkycMisfit_token = token
        super.init(url : self.base_url, token : self.EkycMisfit_token)
    }
}
