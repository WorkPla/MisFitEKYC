//
//  Covid-19PackageListViewController.swift
//  LifePlus BD
//
//  Created by Shuvo on 7/18/22.
//

import UIKit

class Covid_19PackageListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func gotoNotification(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goto_notificationpage", sender: self)
    }
}
