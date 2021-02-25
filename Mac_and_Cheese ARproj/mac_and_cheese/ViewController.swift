//

import UIKit
import SceneKit
import ARKit
import UIKit;

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var Instructions: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    
    let MAX_STEP_NUM = 3 //Full amount of steps in process
    let MIN_STEP_NUM = 0 //Minimum Step number (Should probably be one)
    let MAX_IMAGES_USED = 2 //Largest number of pictures used in single step (Based on AR resource group)
    var stepNum = 0 //What Step User is on
    
    @IBAction func prevStep(_ sender: Any) {
        stepNum -= 1 //Go to Previous Step
        if stepNum < MIN_STEP_NUM {
            stepNum = MAX_STEP_NUM
        }
        sessionConfig() //restart AR session due to change in step
    }
    
    @IBAction func nextStep(_ sender: Any) {
        stepNum += 1 //Go to next step
        if stepNum > MAX_STEP_NUM {
            stepNum = MIN_STEP_NUM
        }
        sessionConfig() //restart AR session due to change in step

    }


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
        //Once Everything is loaded in this func runs
        // Create a session configuration
            sessionConfig()
    
    }
    func sessionConfig(){
        let configuration = ARWorldTrackingConfiguration()
        var NextStep = ARReferenceImage.referenceImages(inGroupNamed: "firstStep", bundle: Bundle.main)
        configuration.maximumNumberOfTrackedImages = MAX_IMAGES_USED;

        switch stepNum {
        case 0:
            Instructions.text = "\(stepNum + 1). Identify burner clear of debris" //First Step doesnt have change in references images due to intialization
        case 1:
            NextStep = ARReferenceImage.referenceImages(inGroupNamed: "secondStep", bundle: Bundle.main) //Change AR resource folder to desired Step
            Instructions.text = "\(stepNum + 1). Identify front of Annie's Mac and Cheese Box" //Change instruction text
        default:
            NextStep = ARReferenceImage.referenceImages(inGroupNamed: "firstStep", bundle: Bundle.main) //this should never be used but just in case
        }
 
        configuration.detectionImages = NextStep //set session to newly selected folder
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors]) //reset all image recongition and anchors,
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }




 
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            //Where animations take place, set to display text name of image currently

                    /* https://medium.com/s23nyc-tech/arkit-planes-3d-text-and-hit-detection-1e10335493d
                */

                    let objName = imageAnchor.referenceImage.name //set string value to picture file name of recongized image
                    let text = SCNText(string: objName, extrusionDepth: 2)
                        //setup text value to be used in AR image
                    let material = SCNMaterial() //set material
                    material.diffuse.contents = UIColor.white //text color = BLUE
                    text.materials = [material] //add material (text color) to the node's material list
                    
                    let Textnode = SCNNode() //create new node to place text at
                    Textnode.position = SCNVector3(x:0, y:0.02, z:-0.0)
                    Textnode.scale = SCNVector3(x:0.01, y:0.01, z:-0.01)
                    Textnode.geometry = text
                    
                    node.addChildNode(Textnode) //add node to list of nodes being used
                            }
        
        return node
        
    }

    

class UserSettings: ObservableObject {
   
}
    
}
