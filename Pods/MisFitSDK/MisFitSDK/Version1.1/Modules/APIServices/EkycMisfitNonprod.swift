//
//  EkycMisfitNonprod.swift
//  MisFitSDK
//
//  Created by Shuvo on 7/5/22.
//

import Foundation

public class EkycMisfitNonprod: EKYC {
    let base_url = "https://nonprodocr.wavemoney.io/"
    private var EkycMisfit_token = String()
    public init(token: String) {
        self.EkycMisfit_token = token
        super.init(url : self.base_url, token : self.EkycMisfit_token)
    }
}
