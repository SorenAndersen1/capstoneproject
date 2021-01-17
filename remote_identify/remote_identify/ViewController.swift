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
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "carview", bundle: Bundle.main) {
            
            configuration.detectionImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 8
            
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
            


            if imageAnchor.referenceImage.name == ""{
                //Test to see if when no images found if the program reached this depth
                let objName = "No object found"
                let text = SCNText(string: objName, extrusionDepth: 2)
                let material = SCNMaterial()
                material.diffuse.contents = UIColor.orange
                text.materials = [material]
                
                let Textnode = SCNNode()
                Textnode.position = SCNVector3(x:0, y:0.02, z:-0.0)
                Textnode.scale = SCNVector3(x:0.01, y:0.01, z:-0.01)
                Textnode.geometry = text
                
                node.addChildNode(Textnode)
                
                
            }
            
            else if imageAnchor.referenceImage.name == "hood" {
                // test to see if conditional statements work better than switch staments for ARDEVKIT
                //see below default case of switch statement for explanation of code
                let objName = "Please open hood to continue"
                let text = SCNText(string: objName, extrusionDepth: 2)
                let material = SCNMaterial()
                material.diffuse.contents = UIColor.orange
                text.materials = [material]
                
                let Textnode = SCNNode()
                Textnode.position = SCNVector3(x:0, y:0.02, z:-0.0)
                Textnode.scale = SCNVector3(x:0.01, y:0.01, z:-0.01)
                Textnode.geometry = text
                
                node.addChildNode(Textnode)
                
                
            }
            else {
                switch imageAnchor.referenceImage.name {
                case "airfilter":
                    //wanted to ensure that something was produced when an image was recongized
                    let cylinder = SCNCylinder(radius: (imageAnchor.referenceImage.physicalSize.width / 8), height: (imageAnchor.referenceImage.physicalSize.height / 3))
                    
                    cylinder.firstMaterial?.diffuse.contents = UIColor(hue: 0.7917, saturation: 1, brightness: 1, alpha: 1.0)

                    let planeNode = SCNNode(geometry: cylinder) //this is all simple setup to add a cylinder facing up on top of the center of a recongized object
                    
                    
                    node.addChildNode(planeNode) //add created node
                    
                    /* https://medium.com/s23nyc-tech/arkit-planes-3d-text-and-hit-detection-1e10335493d
                */
                default:
                    let objName = imageAnchor.referenceImage.name //set string value to picture file name of recongized image
                    let text = SCNText(string: objName, extrusionDepth: 2)
                        //setup text value to be used in AR image
                    let material = SCNMaterial() //set material
                    material.diffuse.contents = UIColor.blue //text color = BLUE
                    text.materials = [material] //add material (text color) to the node's material list
                    
                    let Textnode = SCNNode() //create new node to place text at
                    Textnode.position = SCNVector3(x:0, y:0.02, z:-0.0)
                    Textnode.scale = SCNVector3(x:0.01, y:0.01, z:-0.01)
                    Textnode.geometry = text
                    
                    node.addChildNode(Textnode) //add node to list of nodes being used
                    
                    
                }
            }
            

            
        }
        
        
        
        return node
        
    }
    
}
