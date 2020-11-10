//
//  ViewController.swift
//  Dicee
//
//  Created by Angela Yu on 25/01/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//




import UIKit

//
//  ViewController.swift
//  ARKitVisionObjectDetection
//
//  Created by Dennis Ippel on 08/07/2020.
//  Copyright © 2020 Rozengain. All rights reserved.
//
import UIKit
import SceneKit
import ARKit
import Vision
import CoreML

@available(iOS 11.0, *)
@available(iOS 12.0, *)
class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    private var viewportSize: CGSize!
    private var detectRemoteControl: Bool = true
    
    override var shouldAutorotate: Bool { return false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        viewportSize = sceneView.frame.size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    private func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = []
        sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
        detectRemoteControl = true
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor.name == "keyboardObjectAnchor" else { return }
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.01))
        sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.addChildNode(sphereNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard detectRemoteControl,
            let capturedImage = sceneView.session.currentFrame?.capturedImage
            else { return }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: capturedImage, orientation: .leftMirrored, options: [:])
        
        do {
            //TODO changed this to nil since it was using below commented seciton
            try imageRequestHandler.perform(nil)
        } catch {
            print("Failed to perform image request.")
        }
    }
    
    //TODO This is missing the model for ML, we probably don't want to use it
//    lazy var objectDetectionRequest: VNCoreMLRequest = {
//        do {
//            let model = try VNCoreMLModel(for: YOLOv3TinyInt8LUT().model)
//            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
//                self?.processDetections(for: request, error: error)
//            }
//            return request
//        } catch {
//            fatalError("Failed to load Vision ML model.")
//        }
//    }()
    
    func processDetections(for request: VNRequest, error: Error?) {
        guard error == nil else {
            print("Object detection error: \(error!.localizedDescription)")
            return
        }
        
        guard let results = request.results else { return }
        
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation,
                let topLabelObservation = objectObservation.labels.first,
                topLabelObservation.identifier == "keyboard",
                topLabelObservation.confidence > 0.9
                else { continue }
            
            guard let currentFrame = sceneView.session.currentFrame else { continue }
        
            // Get the affine transform to convert between normalized image coordinates and view coordinates
            let fromCameraImageToViewTransform = currentFrame.displayTransform(for: .portrait, viewportSize: viewportSize)
            // The observation's bounding box in normalized image coordinates
            let boundingBox = objectObservation.boundingBox
            // Transform the latter into normalized view coordinates
            let viewNormalizedBoundingBox = boundingBox.applying(fromCameraImageToViewTransform)
            // The affine transform for view coordinates
            let t = CGAffineTransform(scaleX: viewportSize.width, y: viewportSize.height)
            // Scale up to view coordinates
            let viewBoundingBox = viewNormalizedBoundingBox.applying(t)

            let midPoint = CGPoint(x: viewBoundingBox.midX,
                       y: viewBoundingBox.midY)

            let results = sceneView.hitTest(midPoint, types: .featurePoint)
            guard let result = results.first else { continue }

            let anchor = ARAnchor(name: "remoteObjectAnchor", transform: result.worldTransform)
            sceneView.session.add(anchor: anchor)
            
            detectRemoteControl = false
        }
    }
    
    @IBAction private func didTouchResetButton(_ sender: Any) {
        resetTracking()
    }
}
//class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @IBOutlet weak var imageView: UIImageView!
//
//    var pickedImage = false
//
//    override func viewDidAppear(_ animated: Bool) {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) && !pickedImage {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = self
//            imagePickerController.sourceType = .photoLibrary
//            self.present(imagePickerController, animated: true, completion: nil)
//            pickedImage = true
//        }
//    }
//
//  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//    print("cancelled")
//        self.dismiss(animated: true, completion: nil)
//   }
////
//
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            //save image
//            //display image
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
    
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//
//
//            imageView.image = image
//        print("selected");
//            self.dismiss(animated: true, completion: { () -> Void in
//            })
//
//    }
//    @IBOutlet weak var diceImageView1: UIImageView!
//    @IBOutlet weak var diceImageView2: UIImageView!
//
//
//    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6", ]
//
//
//
//    var randomDiceIndex1 : Int = 0
//    var randomDiceIndex2 : Int = 0
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//
//
//    func updateDiceImages() {
//
//
//        randomDiceIndex1 = Int(arc4random_uniform(6))
//        randomDiceIndex2 = Int(arc4random_uniform(6))
//
//        print(randomDiceIndex1)
//
//        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
//        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
//
//    }
//
//
//
//
//
//    @IBAction func rollButtonPressed(_ sender: UIButton) {
//        updateDiceImages()
//    }
//
//
//
//
//
//    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//
//            updateDiceImages()
//
//
//        }
//
//    }
    
    
    
    


