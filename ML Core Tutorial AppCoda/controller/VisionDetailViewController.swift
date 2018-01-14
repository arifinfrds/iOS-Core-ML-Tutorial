//
//  VisionDetailViewController.swift
//  ML Core Tutorial AppCoda
//
//  Created by Arifin Firdaus on 1/15/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import UIKit
import Vision

class VisionDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    
    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classifierLabel: UILabel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    @IBAction func cameraPressed(_ sender: Any) {
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
    
    @IBAction func libraryPressed(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func buttonSeeTutorialPressed(_ sender: Any) {
        let url = URL(string: "https://www.youtube.com/watch?v=d0U5j89M6aI&t=63s")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    internal func detechFace(with image: UIImage) {
        print("detechFace()")
        
        let detectFaceRectanglesRequest = VNDetectFaceRectanglesRequest { (vnRequest, error) in
            if error != nil {
                print("Error : \(String(describing: error?.localizedDescription))")
            } else {
                print("vnRequest:\(vnRequest)")
                guard let results = vnRequest.results else { return }
                print("results: \(results)")
                
                vnRequest.results?.forEach({ (result) in
                    
                    guard let faceObservation = result as? VNFaceObservation else { return }
                    print("faceObservation.boundingBox: \(faceObservation.boundingBox)")
                    self.drawRectangleView(with: faceObservation)
                    self.classifierLabel.text = faceObservation.landmarks?.allPoints?.description
                })
            }
        }
        
        guard let cgImage = image.cgImage else { return }
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try imageRequestHandler.perform([detectFaceRectanglesRequest])
        } catch {
            print("error : \(error.localizedDescription)")
        }
        
    }
    
    private func drawRectangleView(with faceObservation: VNFaceObservation) {
        
        let x = self.view.frame.width * faceObservation.boundingBox.origin.x
        let width = self.view.frame.width * faceObservation.boundingBox.width
        let height = width
        let y = (1 - faceObservation.boundingBox.origin.y)
        
        let rectView = UIView()
        rectView.backgroundColor = .red
        rectView.alpha = 0.4
        rectView.frame = CGRect(x: x, y: y, width: width, height: height)
        view.addSubview(rectView)
    }
    
}


// MARK: - UIImagePickerControllerDelegate
extension VisionDetailViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        classifierLabel.text = "Analyzing Image..."
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            return
        }
        imageView.image = image
        print(image.description)
        dismiss(animated: true, completion: nil)
        detechFace(with: image)
    }
}



