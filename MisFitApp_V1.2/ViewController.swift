//
//  ViewController.swift
//  MisFitApp_V1.2
//
//  Created by Shuvo on 6/30/22.
//

import UIKit
import MisFitSDK
import FNineSeven

class ViewController: UIViewController, UINavigationControllerDelegate {
    var selectedTag = -1
//    private var tableModel = [
//        "NRC INFO",
//        "NRC SIDE INFO",
//        "FACE DETECT",
//        "FACE DETECT CAMERA",
//        "FACE COMPARE",
//        "PASSPORT DETAILS",
//        "PASSPORT DETAILS",
//        "CAMBODIAN NRC"
//    ]
    private var tableModel = [
        "NRC INFO",
        "NRC SIDE INFO",
        "FACE DETECT",
        "FACE COMPARE",
        "PASSPORT DETAILS"
    ]
    private var responseData : Any?
    private var selectedApi = ""
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTable()
    }

    private func setupTable() {
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        table.delegate = self
        table.dataSource = self
    }
    
    private func gotoResponseView() {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "BottomPopupView") as? BottomPopupView else { return }
        popupVC.responseData = self.responseData
        self.present(popupVC, animated: true, completion: nil)
        NineSeven00().removeLoder(view: self.view)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        cell.tableViewCellButton.setTitle(tableModel[indexPath.row], for: .normal)
        cell.tableViewCellButton.layer.borderWidth = 0.3
        cell.tableViewCellButton.layer.cornerRadius = 5
        cell.tableViewCellButton.tag = indexPath.row
        cell.tableViewCellButton.layer.shadowColor = UIColor.black.cgColor
        cell.tableViewCellButton.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        cell.tableViewCellButton.layer.shadowRadius = 8
        cell.tableViewCellButton.layer.shadowOpacity = 0.5
        cell.tableViewCellButton.layer.masksToBounds = false
        cell.tableViewCellButton.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        return cell
    }
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        self.selectedTag = buttonTag
        self.btnClicked(buttonTag: buttonTag)
    }
}

extension ViewController {
    private func ekyc_get_cardinfo(img : UIImage) {
        let ekyc = EKYC()
        ekyc.get_cardinfo(media1: img, cbm: false, filter: true, source: "other", check_age: false) { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_get_cardside(img : UIImage) {
        let ekyc = EKYC()
        ekyc.get_cardside(media1: img) { jsonData in
            self.responseData = jsonData
            if let dict = jsonData as? [String: Any] {
                let value = dict["type"] as! String
                if value == "back" {
                    
                }
                else {
                    
                }
            }
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_face_detect(img : UIImage) {
        let ekyc = EKYC()
        ekyc.get_face_detect(media1: img) { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_get_comp(img1 : UIImage, img2 : UIImage) {
        let ekyc = EKYC()
        ekyc.get_face_comparison(media1: img1, media2: img2) { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_get_psddportinfo(img : UIImage) {
        let ekyc = EKYC()
        ekyc.get_passportdetails(media1: img, check_expiry: false, check_age: false) { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
}

extension ViewController {
    private func btnClicked(buttonTag : Int) {
        ImagePickerManager().pickImage(self){ image in
                //here is the image
            NineSeven00().addLoder(view: self.view)
            if self.tableModel[self.selectedTag] == "NRC INFO" {
                self.selectedApi = "NRC INFO"
                self.ekyc_get_cardinfo(img: image)
            }
            else if self.tableModel[self.selectedTag] == "NRC SIDE INFO" {
                self.selectedApi = "NRC SIDE INFO"
                self.ekyc_get_cardside(img: image)
            }
            else if self.tableModel[self.selectedTag] == "FACE DETECT" {
                self.selectedApi = "FACE DETECT"
                self.ekyc_face_detect(img: image)
            }
            else if self.tableModel[self.selectedTag] == "FACE COMPARE" {
                self.selectedApi = "FACE COMPARE"
                ImagePickerManager().pickImage(self) { image2 in
                    self.ekyc_get_comp(img1: image, img2: image2)
                }
            }
            else if self.tableModel[self.selectedTag] == "PASSPORT DETAILS" {
                self.selectedApi = "PASSPORT DETAILS"
                self.ekyc_get_psddportinfo(img: image)
            }
        }
    }
}
