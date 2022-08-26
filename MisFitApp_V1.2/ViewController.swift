//
//  ViewController.swift
//  MisFitApp_V1.2
//
//  Created by Shuvo on 6/30/22.
//

import UIKit
import MisFitSDK
import FNineSeven
import Photos
import PhotosUI
import AVKit
import ImageIO
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate {
    private var img1 : Any? = nil
    private var img2 : Any? = nil
    
    private var token = "Token eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE2NTQxNTY0NjB9.KyDGBi4yB-QvIjC8PjliDDVlM0add8rG90RoIn0hfnM"
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
        "FACE DETECT FILE",
        "FACE DETECT STRING",
        "FACE COMPARE FILE",
        "FACE COMPARE STRING",
        "PASSPORT DETAILS",
        "NRC INFO WITH LAYER"
    ]
    private var responseData : Any?
    private var selectedApi = ""
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Photos
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    
                    print(status)
                    if status == .authorized{
                        print("authorized")
                    } else {}
                })
            }
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
        let im = (img as? UIImage)!.jpegData(compressionQuality: 0.1)! as NSData
        let str : String = im.base64EncodedString(options: [])
        let ekyc = EkycMisfitNonprod(token: self.token)
        ekyc.get_cardinfo(media1: str, cbm: false, filter: true, source: "other", check_age: false) { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_get_cardside(img : UIImage) {
        let im = (img as? UIImage)!.jpegData(compressionQuality: 0.1)! as NSData
        let str : String = im.base64EncodedString(options: [])
        let ekyc = EkycMisfitNonprod(token: self.token)
        ekyc.get_cardside(media1: str) { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_get_cardinfo_with_layer(img : UIImage) {
        let im = (img as? UIImage)!.jpegData(compressionQuality: 0.1)! as NSData
        let str : String = im.base64EncodedString(options: [])
        let ekyc = EkycMisfitNonprod(token: self.token)
        ekyc.get_cardinfo_with_face(media1: str, cbm: false, filter: true, source: "other", check_age: false) { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_face_detect(img : Any) {
        let ekyc = EkycMisfitNonprod(token: self.token)
        DispatchQueue.main.async {
            ekyc.get_face_detect(File: img) { jsonData in
                self.responseData = jsonData
                DispatchQueue.main.async {
                    self.gotoResponseView()
                }
            }
        }
    }
    public func ekyc_face_detect_str(img : Any) {
        let ekyc = EkycMisfitNonprod(token: self.token)
        let im = (img as? UIImage)!.jpegData(compressionQuality: 0.1)! as NSData
        DispatchQueue.main.async {
            ekyc.get_face_detect(String: im.base64EncodedString(options: [])) { jsonData in
                self.responseData = jsonData
                DispatchQueue.main.async {
                    self.gotoResponseView()
                }
            }
        }
    }
    public func ekyc_get_comp(img1 : Any?, img2 : Any?) {
        let ekyc = EkycMisfitNonprod(token: self.token)
        ekyc.get_face_comparison(File1: img1, File2: img2, File2Tpe: "nrc") { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_get_comp_str(img1 : Any?, img2 : Any?) {
        let im1 = (img1 as? UIImage)!.jpegData(compressionQuality: 0.1)! as NSData
        let im2 = (img2 as? UIImage)!.jpegData(compressionQuality: 0.1)! as NSData
        let ekyc = EkycMisfitNonprod(token: self.token)
        ekyc.get_face_comparison(String1: im1.base64EncodedString(options: []), String2: im2.base64EncodedString(options: []), Image2Type: "nrc") { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
    public func ekyc_get_psddportinfo(img : UIImage) {
        let im = (img as? UIImage)!.jpegData(compressionQuality: 0.1)! as NSData
        let str : String = im.base64EncodedString(options: [])
        let ekyc = EkycMisfitNonprod(token: self.token)
        ekyc.get_passportinfo_with_face(media1: str, source: "other", check_age: false) { jsonData in
            self.responseData = jsonData
            DispatchQueue.main.async {
                self.gotoResponseView()
            }
        }
    }
}

extension ViewController {
    private func btnClicked(buttonTag : Int) {
        self.img1 = nil
        self.img2 = nil
        self.selectedApi = self.tableModel[self.selectedTag]
        NineSeven00().addLoder(view: self.view)
        DispatchQueue.main.async {
            self.pickImages()
        }
    }
    
    private func pickImages() {
        do {
            // if you create the configuration with no photo library, you will not get asset identifiers
            var config = PHPickerConfiguration()
            // try it _with_ the library
            config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            config.selectionLimit = 1 // default
            // what you filter out will indeed not appear in the picker
            //config.filter = .livePhotos // default is all three appear, no filter
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            // works okay as a popover but even better just present, it will be a normal sheet
            self.present(picker, animated: true)
        }
    }
    
    private func processData(image : Any?, image2: Any?) {
        if self.tableModel[self.selectedTag] == "NRC INFO" {
            self.selectedApi = "NRC INFO"
            self.ekyc_get_cardinfo(img: image as! UIImage)
        }
        else if self.tableModel[self.selectedTag] == "NRC SIDE INFO" {
            self.selectedApi = "NRC SIDE INFO"
            self.ekyc_get_cardside(img: image as! UIImage)
        }
        else if self.tableModel[self.selectedTag] == "FACE DETECT FILE" {
            self.selectedApi = "FACE DETECT FILE"
            self.ekyc_face_detect(img: image)
        }
        else if self.tableModel[self.selectedTag] == "FACE DETECT STRING" {
            self.selectedApi = "FACE DETECT STRING"
            self.ekyc_face_detect_str(img: image)
        }
        else if self.tableModel[self.selectedTag] == "FACE COMPARE FILE" {
            self.selectedApi = "FACE COMPARE FILE"
            self.ekyc_get_comp(img1: image, img2: image2)
        }
        else if self.tableModel[self.selectedTag] == "FACE COMPARE STRING" {
            self.selectedApi = "FACE COMPARE STRING"
            self.ekyc_get_comp_str(img1: image, img2: image2)
        }
        else if self.tableModel[self.selectedTag] == "PASSPORT DETAILS" {
            self.selectedApi = "PASSPORT DETAILS"
            self.ekyc_get_psddportinfo(img: image as! UIImage)
        }
        else if self.tableModel[self.selectedTag] == "NRC INFO WITH LAYER" {
            self.selectedApi = "NRC INFO WITH LAYER"
            self.ekyc_get_cardinfo_with_layer(img: image as! UIImage)
        }
    }
}
extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) { // NB if you don't say this, it won't dismiss!
            print(Thread.isMainThread) // yep
            guard let result = results.first else { return }
            // proving you don't get asset id unless you specified library
            let assetid = result.assetIdentifier
            print(assetid as Any)
            // what did we get? I think the way to find out is to ask the provider
            let prov = result.itemProvider
            let types = prov.registeredTypeIdentifiers
            print("types:", types)
            // for image, "public.jpeg" or "public.png" etc
            // for video, "com.apple.quicktime-movie"
            // for live photo, ["com.apple.live-photo-bundle", "public.jpeg"]
            // for looping live photo, ["com.apple.private.auto-loop-gif", "com.apple.quicktime-movie", "com.compuserve.gif"]
            
            // NB UTType is new in iOS 14! where did they document this????
            DispatchQueue.main.async {
                if prov.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                    self.dealWithVideo(result)
                } else if prov.canLoadObject(ofClass: PHLivePhoto.self) {
                    self.dealWithLivePhoto(result)
                } else if prov.canLoadObject(ofClass: UIImage.self) {
                    self.dealWithImage(result)
                }
            }
            
        }
    }
}
extension ViewController {
    fileprivate func dealWithVideo(_ result: PHPickerResult) {
        print(self.selectedApi)
            let movie = UTType.movie.identifier
            let prov = result.itemProvider
            prov.loadFileRepresentation(forTypeIdentifier: movie) { url, err in
                if let url = url {
                    DispatchQueue.main.sync {
                        print(url)
                        if (self.selectedApi == "FACE COMPARE STRING" || self.selectedApi == "FACE COMPARE FILE") && self.img1 == nil {
                            do {
                                let video = try Data(contentsOf: url, options: .mappedIfSafe)
                                self.img1 = video
                            } catch {
                                print(error)
                                return
                            }
                            DispatchQueue.main.async {
                                self.pickImages()
                            }
                        }
                        else if (self.selectedApi == "FACE COMPARE STRING" || self.selectedApi == "FACE COMPARE FILE") && self.img1 != nil {
                            do {
                                let video = try Data(contentsOf: url, options: .mappedIfSafe)
                                self.img2 = video
                            } catch {
                                print(error)
                                return
                            }
                            DispatchQueue.main.async {
                                self.processData(image: self.img1, image2: self.img2)
                            }
                        }
                        else {
                            do {
                                let video = try Data(contentsOf: url, options: .mappedIfSafe)
                                self.img1 = video
                            } catch {
                                print(error)
                                return
                            }
                            DispatchQueue.main.async {
                                self.processData(image: self.img1, image2: nil)
                            }
                        }
                        
                        let loopType = "com.apple.private.auto-loop-gif"
                        if prov.hasItemConformingToTypeIdentifier(loopType) {
                            print("looping movie")
                            //self.showLoopingMovie(url: url)
                        } else {
                            print("normal movie")
                            //self.showMovie(url: url)
                        }
                    }
                }
            }
        }
        
        // the other cases are easy; just load the data as objects
        fileprivate func dealWithLivePhoto(_ result: PHPickerResult) {
            let prov = result.itemProvider
            prov.loadObject(ofClass: PHLivePhoto.self) { livePhoto, err in
                if let im = livePhoto as? PHLivePhoto {
                    DispatchQueue.main.async {
                        if (self.selectedApi == "FACE COMPARE STRING" || self.selectedApi == "FACE COMPARE FILE") && self.img1 == nil {
                            self.img1 = im
                            DispatchQueue.main.async {
                                self.pickImages()
                            }
                        }
                        else if (self.selectedApi == "FACE COMPARE STRING" || self.selectedApi == "FACE COMPARE FILE") && self.img1 != nil {
                            self.img2 = im
                            DispatchQueue.main.async {
                                self.processData(image: self.img1, image2: self.img2)
                            }
                        }
                        else {
                            self.img1 = im
                            DispatchQueue.main.async {
                                self.processData(image: im, image2: nil)
                            }
                        }
                    }
                }
            }
        }
        
        fileprivate func dealWithImage(_ result: PHPickerResult) {
            let prov = result.itemProvider
            prov.loadObject(ofClass: UIImage.self) { im, err in
                if let im = im as? UIImage {
                    if (self.selectedApi == "FACE COMPARE STRING" || self.selectedApi == "FACE COMPARE FILE") && self.img1 == nil {
                        self.img1 = im
                        DispatchQueue.main.async {
                            self.pickImages()
                        }
                    }
                    else if (self.selectedApi == "FACE COMPARE STRING" || self.selectedApi == "FACE COMPARE FILE") && self.img1 != nil {
                        self.img2 = im
                        DispatchQueue.main.async {
                            self.processData(image: self.img1, image2: self.img2)
                        }
                    }
                    else {
                        self.img1 = im
                        DispatchQueue.main.async {
                            self.processData(image: im, image2: nil)
                        }
                    }
                }
            }
        }
}
