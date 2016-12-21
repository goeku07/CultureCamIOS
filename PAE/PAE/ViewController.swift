//
//  ViewController.swift
//  PAE
//
//  Created by Gökhan on 15/12/2016.
//  Copyright © 2016 Gökhan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    
    @IBOutlet weak var btnMore: UIButton!
    
    @IBOutlet weak var btnAbout: UIButton!
    @IBOutlet weak var btnContent: UIButton!
    @IBOutlet weak var btnFeedback: UIButton!
    
    @IBOutlet weak var btnCam: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var btnGo: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var showInfo = true
    var showCam = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        btnAbout.isHidden = true
        btnContent.isHidden = true
        btnFeedback.isHidden = true
        
        cameraButton.isHidden = true
        photoLibraryButton.isHidden = true
        btnGo.isHidden = true
        
        // Die Buttons sollen im Vordergrund stehen
        self.view.bringSubview(toFront: cameraButton)
        self.view.bringSubview(toFront: photoLibraryButton)
    }
    
    /// Diese Methode behandelt die Funktionalität wenn der "Camera" - Button getätigt wurde
    ///
    /// - parameter sender: der Sender
    @IBAction func onClickCameraButton(_ sender: Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /// Diese Methode behandelt die Funktionalität wenn der "Photo Library" - Button getätigt wurde
    ///
    /// - parameter sender: der Sender
    @IBAction func onClickPhotoLibraryButton(_ sender: Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    ///
    func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!)
    {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        // das ausgewählte Bild wird in dieser Variable gespeichert
        //var newImage: UIImage
        //newImage = image
        
        
        //var i = 0
        //var someString = [String]()
        //let data = Data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let link = "http://image-similarity.ait.ac.at/culturecam-web/searchByUrl.json?queryImageUrl=http://m.androidwallpapercentral.com/downloads/androidwallpaper-FierceBlueDragon.jpg&start=0&rows=12&wskey=xy&profile=similarimage"
        //let url = URL(string: urlString)
        
        var names = [String]()
        let data = NSData(contentsOfFile: link)
        
        do {
            if let data = data,
                let json = try JSONSerialization.jsonObject(with: data as Data) as? [String: Any],
                let blogs = json["itmes"] as? [[String: Any]]
            {
                for blog in blogs
                {
                    if let name = blog["cachedThmbUrl"] as? String
                    {
                        names.append(name)
                    }
                }
            }
        }
        catch
        {
            print("Error deserializing JSON: \(error)")
        }
        
        print(names)
    }
    
    @IBAction func onClickBtnMore(_ sender: Any)
    {
        if showInfo == true
        {
            btnAbout.isHidden = false
            btnContent.isHidden = false
            btnFeedback.isHidden = false
            showInfo = false
        }
        else
        {
            btnAbout.isHidden = true
            btnContent.isHidden = true
            btnFeedback.isHidden = true
            showInfo = true
        }
    }
    
    @IBAction func onClickBtnCam(_ sender: Any)
    {
        if showCam == true
        {
            cameraButton.isHidden = false
            photoLibraryButton.isHidden = false
            btnGo.isHidden = false
            showCam = false
        }
        else
        {
            cameraButton.isHidden = true
            photoLibraryButton.isHidden = true
            btnGo.isHidden = true
            showCam = true
        }
    }
    
    @IBAction func onClickBtnAbout(_ sender: Any)
    {
        let text = "Culture Cam is a webcam based similarity search tool offering designers, artists and all creative people the possibility to explore cultural heritage images on Europeana in a fun, playful and intuitive way."
        
        
        let alertController = UIAlertController(title: "About", message:
            text, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onClickBtnContent(_ sender: Any)
    {
        let text = "Culture Cam is based on open images and data from Europeana and Europeana Labs."
        
        
        let alertController = UIAlertController(title: "Content", message:
            text, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onClickBtnFeedback(_ sender: Any)
    {
        let text = "Culture Cam is a working prototype and we would like to hear your comments and feedback on how to make it work better."
        
        
        let alertController = UIAlertController(title: "Feedback", message:
            text, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
