//
//  ViewController.swift
//  CustomCameraAssignment
//
//  Created by Shantaram K on 17/07/20.
//  Copyright © 2020 Sidram K. All rights reserved.
//

import UIKit
import SKCamera

class ViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var captureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: - Action

extension ViewController {
    
    @IBAction func captureButtonClicked() {
       openSKcamera()
    }
    
    func openSKcamera() {
          let skCamera = SKCameraManager()
          skCamera.delegate = self
          skCamera.open()
      }
}

extension ViewController: SKCameraProtocol {
    
    func skCameraManager(_ skCamera: SKCameraManager, didFinishPickingImage image: UIImage?) {
        self.captureImageView.image = image
    }

    func skCameraManager(_ skCamera: SKCameraManager, didSavedImage image: UIImage?) {
          self.captureImageView.image = image
    }

}
