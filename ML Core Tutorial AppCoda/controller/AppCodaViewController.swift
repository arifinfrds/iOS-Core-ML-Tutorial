//
//  ViewController.swift
//  ML Core Tutorial AppCoda
//
//  Created by Arifin Firdaus on 10/5/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

// https://www.appcoda.com/coreml-introduction/
import UIKit
import CoreML

class AppCodaViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelClassifier: UILabel!
    
    var model: Inceptionv3!
    
    
    // MARK: - View life cycle
    override func viewWillAppear(_ animated: Bool) {
        model = Inceptionv3()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - IBAction
    @IBAction func btnGoToLinkDidTapped(_ sender: Any) {
        let url = URL(string: "https://www.appcoda.com/coreml-introduction/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    @IBAction func cameraDidTapped(_ sender: Any) {
        // check is camera not available
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func libraryDidTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AppCodaViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        labelClassifier.text = "Analyzing Image..."
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        imageView.image = newImage
        
        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
            return
        }
        
        dump(prediction.classLabelProbs)
        
        if let accuracyPoint = prediction.classLabelProbs[prediction.classLabel] {
            let accuracyPercentage = accuracyPoint * 100
            let formattedAccuracyPoint = String(format:"%.2f", accuracyPercentage)
            labelClassifier.text = "It's probably a \(prediction.classLabel) with \(formattedAccuracyPoint) accuracy."
        }
        
    }
    
}






