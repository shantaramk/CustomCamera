//
//  SKCameraViewController+UI.swift
//  ButtonExtension
//
//  Created by Shantaram K on 14/07/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - UI

extension SKCameraViewController {
    
    func configureUI() {
        configureView()
        configureButton()
        configureTapGuesture()
    }
    
    func configureButton() {
        self.captureImageView.layer.cornerRadius = 10
    }
    
    func configureView() {
        //self.previewView.layer.cornerRadius = 50.0
        previewView.layer.masksToBounds = true

    }
    
    func configureTapGuesture() {
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        self.captureImageView?.addGestureRecognizer(tapgesture)
    }
    func configureCaptureSession() {
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        configureDeviceInput(forPosition: .back)
    }

    func configureDeviceInput(forPosition position: AVCaptureDevice.Position) {
        do {
            let camera = getDevice(position: position)

            let input = try AVCaptureDeviceInput(device: camera!)
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                configureLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func configureLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        videoPreviewLayer?.frame = previewView.layer.bounds
        previewView.layer.addSublayer(videoPreviewLayer)
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }
    
    //Get the device (Front or Back)
    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices() as NSArray;
       for de in devices {
          let deviceConverted = de as! AVCaptureDevice
          if(deviceConverted.position == position){
             return deviceConverted
          }
       }
       return nil
    }
    
}
