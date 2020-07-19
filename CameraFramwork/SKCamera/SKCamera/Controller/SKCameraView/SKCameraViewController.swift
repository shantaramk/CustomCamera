//
//  SKCameraViewController.swift
//  ButtonExtension
//
//  Created by Sidram K on 14/07/20.
//  Copyright © 2020 Sidram K. All rights reserved.
//

import UIKit
import AVFoundation

enum CaptureState {
    case capture
    case retake
    case none
}

enum CameraPositionState {
    case front
    case back
    case none
}

class SKCameraViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var previewView: UIView!
    
    // MARK: - Properties
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var captureState: CaptureState = .capture
    var cameraPositionState: CameraPositionState = .back
    
    var selectedImage: UIImage?
    var imageCaptureCompletionHandler: ((UIImage?, Bool) -> Void)?
    var imageSaveCompletionHandler: ((UIImage?, Bool) -> Void)?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Setup your camera here...
        configureCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    func actionCaptureCompletionHandler(action:@escaping (UIImage?, Bool) -> Void) {
        self.imageCaptureCompletionHandler = action
    }
    
    func actionSavedCompletionHandler(action:@escaping (UIImage?, Bool) -> Void) {
        self.imageSaveCompletionHandler = action
    }
}

// MARK: - Action

extension SKCameraViewController {
    
    @IBAction func captureButtonClicked() {
        if self.captureState == .capture {
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            stillImageOutput.capturePhoto(with: settings, delegate: self)
        } else {
            updateUI()
        }
    }
    
    @IBAction func switchCameraClicked() {
        if cameraPositionState == .back {
            cameraPositionState = .front
        } else {
            cameraPositionState = .back
        }
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        configureDeviceInput(forPosition: (cameraPositionState == .back) ? .back : .front)
    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        loadImageViewer(self.selectedImage)
    }
    
    func imageSaved(_ image: UIImage?) {
        self.dismiss(animated: false, completion: {
        })
        if let captureImage = image {
            self.imageSaveCompletionHandler!(captureImage, false)
        } else {
            self.imageSaveCompletionHandler!(nil, true)
        }
    }
}

// MARK: - Private Method

extension SKCameraViewController {
    
    func loadImageViewer(_ image: UIImage?) {
        let bundle = Bundle(for: SKImageViewerController.self)
        let imageViewer = SKImageViewerController(nibName: "SKImageViewerController", bundle: bundle)
        imageViewer.image = image
        imageViewer.sKCameraView = self
        self.present(imageViewer, animated: true, completion: nil)
    }
    
}
