//
//  ViewController.swift
//  iOSCoreMLDemo
//
//  Created by John Lima on 13/12/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//
//  https://developer.apple.com/machine-learning/

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private var categoryLabel: UILabel!
    
    let model = GoogLeNetPlaces()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    @IBAction private func selectImage(sender: UITapGestureRecognizer) {
        let imageView = sender.view as? UIImageView
        guard let imageToAnalyse = imageView?.image, let sceneLabelString = sceneLabel(forImage: imageToAnalyse) else {
            categoryLabel.text = "Error"
            categoryLabel.textColor = .red
            return
        }
        categoryLabel.text = sceneLabelString
        categoryLabel.textColor = .black
    }
    
    private func sceneLabel(forImage image: UIImage) -> String? {
        if let cgImage = image.cgImage, let pixelBuffer = ImageProcessor.pixelBuffer(forImage: cgImage) {
            guard let scene = try? model.prediction(sceneImage: pixelBuffer) else { fatalError("unexpected runtime error") }
            return scene.sceneLabel
        }
        return nil
    }
}

