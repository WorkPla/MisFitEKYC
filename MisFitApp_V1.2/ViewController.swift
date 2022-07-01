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
    private var tableModel = [
        "NRC INFO",
        "NRC SIDE INFO",
        "FACE DETECT",
        "FACE DETECT CAMERA",
        "FACE COMPARE",
        "PASSPORT DETAILS",
        "PASSPORT DETAILS",
        "CAMBODIAN NRC"
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
    private func apiNRCDetails(img : UIImage) {
        NineSeven00().addLoder(view: self.view)
        let apiNRCDetailsApi = NRCDetailsApi()
        apiNRCDetailsApi.apiRequestForNrcCDetails(media1: img) { jsonData in
            self.responseData = jsonData
            
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    private func apiNRCDetect(img : UIImage) {
        NineSeven00().addLoder(view: self.view)
        let apiNRCDetectApi = NRCDetectApi()
        apiNRCDetectApi.apiRequestForNRCDetect(media1: img) { jsonData in
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
            if self.tableModel[self.selectedTag] == "NRC INFO" {
                self.selectedApi = "NRC INFO"
                self.apiNRCDetails(img: image)
            }
            else if self.tableModel[self.selectedTag] == "NRC SIDE INFO" {
                self.selectedApi = "NRC SIDE INFO"
                self.apiNRCDetect(img: image)
            }
        }
    }
}
