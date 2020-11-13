//
//  CameraViewController.swift
//  Snapcat
//
//  Created by Sai Kambampati on 8/21/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import ARKit

class CameraViewController: UIViewController {
    
    @IBOutlet var previewView: ARSCNView!
    var timer : Timer?
    var rectangleView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        previewView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        previewView.session.run(configuration)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.detectCat), userInfo: nil, repeats: true)
    }
    
    @objc func detectCat() {
         self.rectangleView.removeFromSuperview()
        guard let currentFrameBuffer = self.previewView.session.currentFrame?.capturedImage else { return }
            let image = CIImage(cvPixelBuffer: currentFrameBuffer)
            let detectRequest = VNDetectRectanglesRequest { (request, error) in
                DispatchQueue.main.async {
                    if let results = request.results as? [VNRectangleObservation] {
                            
                    
//                        let cats = results.labels.filter({$0.identifier == "Cat"})
                        for res in results {
                            self.rectangleView = UIView(frame: CGRect(x: res.boundingBox.minX * self.previewView.frame.width, y: res.boundingBox.minY * self.previewView.frame.height, width: res.boundingBox.width * self.previewView.frame.width, height: res.boundingBox.height * self.previewView.frame.height))
                             
                                self.rectangleView.backgroundColor = .clear
                                self.rectangleView.layer.borderColor = UIColor.red.cgColor
                                self.rectangleView.layer.borderWidth = 3
                                                    self.previewView.insertSubview(self.rectangleView, at: 0)
                        }
                    }
                }
            }
         
            DispatchQueue.global().async {
                try? VNImageRequestHandler(ciImage: image).perform([detectRequest])
            }
    }

    @IBAction func snap(_ sender: Any) {
        let currentFrame = previewView.snapshot()
        let vc = self.storyboard?.instantiateViewController(identifier: "Profile") as! CatProfileViewController
        vc.catImage = currentFrame
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CameraViewController: ARSCNViewDelegate {
    
}
