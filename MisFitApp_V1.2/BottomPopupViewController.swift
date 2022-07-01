//
//  BottomPopupViewController.swift
//  MisFitApp_V1.2
//
//  Created by Shuvo on 6/30/22.
//

import UIKit
import BottomPopup

class BottomPopupView: BottomPopupViewController {
    var responseData : Any?
    @IBOutlet weak var apiReaponse: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        apiReaponse.text = converter(responseData)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func converter(_ value:Any?) -> String {
        if let nonNil = value, !(nonNil is NSNull) {
            return String(describing: nonNil)
        }
        return "Local Log: Data not found."
    }
    override var popupHeight: CGFloat { return CGFloat(350) }
    
    override var popupTopCornerRadius: CGFloat { CGFloat(10) }
    
    override var popupPresentDuration: Double { return 0.5 }
    
    override var popupDismissDuration: Double { return 0.5 }
    
    override var popupShouldDismissInteractivelty: Bool { return true }
    
    override var popupDimmingViewAlpha: CGFloat { return 0.5 }
}
