//
//  SKImageViewerController.swift
//  ButtonExtension
//
//  Created by Shantaram K on 16/07/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import UIKit

class SKImageViewerController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var rotateButton: UIButton!
    @IBOutlet weak var captureImageView: UIImageView!
    
    // MARK: - Properties
    var image: UIImage?
    var sKCameraView: SKCameraViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setData()
    }

    func setData() {
        if let captureimage = image {
            captureImageView.image = captureimage
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Action

extension SKImageViewerController {
    
    @IBAction func saveButtonClicked() {
        if let image = captureImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(SKImageViewerController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @IBAction func rotateButtonClicked() {
        if let image = captureImageView.image {
            let newImage = image.rotate(radians: .pi/2) // Rotate 90 degrees
            captureImageView.image = newImage
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (_) -> Void in
                self.dismiss(animated: false, completion: {
                    self.sKCameraView?.imageSaved(self.captureImageView.image)
                })
             })
            ac.addAction(okButton)
            present(ac, animated: true)
        }
    }
}
