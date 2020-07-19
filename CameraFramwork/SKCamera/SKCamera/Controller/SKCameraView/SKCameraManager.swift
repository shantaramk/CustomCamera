//
//  SKCameraManager.swift
//  ButtonExtension
//
//  Created by Shantaram K on 14/07/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import UIKit

public protocol SKCameraProtocol {
    
    func skCameraManager(_ skCamera: SKCameraManager, didFinishPickingImage image: UIImage?)
    func skCameraManager(_ skCamera: SKCameraManager, didSavedImage image: UIImage?)
}

public class SKCameraManager: NSObject {
    
    public var delegate: SKCameraProtocol?
    
    public override init() {}
    
    public func viewController() -> UIViewController {
        let bundle = Bundle(for: SKCameraViewController.self)
        let cameraViewController = SKCameraViewController(nibName: "SKCameraViewController", bundle: bundle)
        cameraViewController.actionCaptureCompletionHandler { (image, _) in
            self.delegate!.skCameraManager(self, didFinishPickingImage: image)
        }
        cameraViewController.actionSavedCompletionHandler { (image, _) in
            self.delegate!.skCameraManager(self, didSavedImage: image)
        }
        return cameraViewController
    }
    
    public func open () {
        if let delegate = self.delegate as? UIViewController {
            let viewInstance = viewController()
            delegate.present(viewInstance, animated: true, completion: nil)
        }
    }
}

