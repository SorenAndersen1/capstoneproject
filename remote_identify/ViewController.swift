//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "remote", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 1
            
            print("Images Successfully Added")

            
        }
        
        
        

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
 
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: (imageAnchor.referenceImage.physicalSize.width / 3), height: (imageAnchor.referenceImage.physicalSize.height / 3))
            
            plane.firstMaterial?.diffuse.contents = UIColor(hue: 0.0861, saturation: 1, brightness: 1, alpha: 1.0) //orange color go beavs!

            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2 // flip plane to be flat
            
            node.addChildNode(planeNode)

            
            
            

            
        }
        
        
        
        return node
        
    }
    
}
