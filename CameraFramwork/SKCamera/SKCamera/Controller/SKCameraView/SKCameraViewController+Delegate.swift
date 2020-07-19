//
//  SKCameraViewController+Delegate.swift
//  ButtonExtension
//
//  Created by Sidram K on 14/07/20.
//  Copyright © 2020 Sidram K. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - AVCapture Photo Capture Delegate

extension SKCameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        captureImageView.image = image
        self.selectedImage = image
        if let image = self.selectedImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.imageCaptureCompletionHandler!(image, false)
        } else {
            self.imageCaptureCompletionHandler!(image, true)
        }
        self.updateUI()
    }
    
    func updateUI() {
        if self.captureState == .capture {
            // captureButton.setTitle("ReTake", for: UIControl.State.normal)
            self.captureState = .retake
        } else {
           // captureButton.setTitle("Capture", for: UIControl.State.normal)
            self.captureState = .capture
        }
    }
}
