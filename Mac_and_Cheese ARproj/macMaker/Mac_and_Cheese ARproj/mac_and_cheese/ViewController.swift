//

import UIKit
import SceneKit
import ARKit
import UIKit;

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var Instructions: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    
    let MAX_STEP_NUM = 12 //Full amount of steps in process
    let MIN_STEP_NUM = 1 //Minimum Step number (Should probably be zero)
    let MAX_IMAGES_USED = 2 //Largest number of pictures used in single step (Based on AR resource group)
    var stepNum = 1 //What Step User is on
    var stepList:[Step]!
    var infoList:[ImageInfo?]!
    
    var stepArrows = ["Down": "ArrowDown",
                            "Left": "ArrowLeft",
                            "Right": "ArrowRight",
                            "Up": "ArrowUp"]
    fileprivate let highlightMaskValue: Int = 2

    @IBAction func prevStep(_ sender: Any) {
        stepNum -= 1 //Go to Previous Step
        if stepNum < MIN_STEP_NUM {
            stepNum = MAX_STEP_NUM - 1
        }
        sessionConfig() //restart AR session due to change in step
    }
    
    @IBAction func nextStep(_ sender: Any) {
        stepNum += 1 //Go to next step
        if stepNum > MAX_STEP_NUM - 1{
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
        stepList = stepSetup(MAX_STEP_NUM: MAX_STEP_NUM) //init steplist
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Once Everything is loaded in this func runs
        // Create a session configuration
        sessionConfig()
    }
    
    func sessionConfig(){
        let configuration = ARWorldTrackingConfiguration()
        var NextStep = ARReferenceImage.referenceImages(inGroupNamed: "1_Step", bundle: Bundle.main)
        configuration.maximumNumberOfTrackedImages = MAX_IMAGES_USED;
        
        Instructions.text = stepList[stepNum].instruction
        NextStep = ARReferenceImage.referenceImages(inGroupNamed: stepList[stepNum].arResourceName, bundle: Bundle.main)
 
        configuration.detectionImages = NextStep //set session to newly selected folder
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors]) //reset all image recongition and anchors,
    }

    
    func stepSetup(MAX_STEP_NUM: Int ) -> [Step]{
        var stepARR:[Step] = [Step]() //setup dummy Step array
        let instructionText = InstructionText(hardCodeType: "macAndCheese") //get Instruction set list from the class
        for n in 0...MAX_STEP_NUM - 1 {
            stepARR.append(Step(identityNum: n, instruction: "\(n). " +  (instructionText.getInstruction(numDesired: n) ))) //assign step values to each step in the array
        }
        infoList = instructionText.getInfos()
        return stepARR //Send the newly made array to the didViewLoad func to allow for usage throughout funcs
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
            var textString = ""
            var arrowDir = "Unknown"
            if let imgInfo = infoList[stepNum*2]{
                if(imgInfo.imgName == objName){
                    textString = imgInfo.appearText
                    arrowDir = imgInfo.arrowDir
                }
                
            }
            if (textString == ""){
                if let imgInfo2 = infoList[stepNum*2 + 1]{
                    if(imgInfo2.imgName == objName){
                        textString = imgInfo2.appearText
                        arrowDir = imgInfo2.arrowDir
                    }
                }
            }
            if(textString != ""){
                    let text = SCNText(string: textString, extrusionDepth: 2)
                        //setup text value to be used in AR image
                    let material = SCNMaterial() //set material
                    material.diffuse.contents = UIColor.white //text color = BLUE
                    text.materials = [material] //add material (text color) to the node's material list
                    
                    let Textnode = SCNNode() //create new node to place text at
                Textnode.position = SCNVector3(x:-0.15, y:0.07, z:0.1)
                    Textnode.scale = SCNVector3(x:0.005, y:0.005, z:-0.005)
                    Textnode.geometry = text
                    
                    node.addChildNode(Textnode) //add node to list of nodes being used
            }
            if(arrowDir != "Unknown"){
                    let image = UIImage(named: stepArrows[arrowDir] ?? "")
            let rotImg = image?.imageByMakingWhiteBackgroundTransparent()
            let Imgnode = SCNNode(geometry: SCNPlane(width: 0.05, height: 0.05))
            Imgnode.position = SCNVector3(x:0.0, y:0.05, z:0.1)
                    Imgnode.geometry?.firstMaterial?.diffuse.contents = rotImg

                    node.addChildNode(Imgnode)
            }
                            }
        //node.setCategoryBitMaskForAllHierarchy(highlightMaskValue)
        return node
        
    }

    

class UserSettings: ObservableObject {
   
}
    
}

extension UIImage {
func imageByMakingWhiteBackgroundTransparent() -> UIImage? {
    if let rawImageRef = self.cgImage {
        //TODO: eliminate alpha channel if exsists
        let colorMasking: [CGFloat] = [200, 255, 200, 255, 200, 255]
        UIGraphicsBeginImageContext(self.size)
        if let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking)
        {
            if let context = UIGraphicsGetCurrentContext(){
                context.translateBy(x: 0.0, y: self.size.height)
                context.scaleBy(x: 1.0, y: -1.0)
                context.draw(maskedImageRef, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
               
            }
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result
        }
    }
    return nil
}
    
    
}

extension SCNNode {
  func setCategoryBitMaskForAllHierarchy(_ highlightedBitMask: Int = 2,
                                         nodesToExclude: Set<String> = Set<String>()) {
    if let selfName = name {
      if !nodesToExclude.contains(selfName) {
        categoryBitMask = highlightedBitMask
      }
    }
    else {
      categoryBitMask = highlightedBitMask
    }
    
    for child in self.childNodes {
      child.setCategoryBitMaskForAllHierarchy(highlightedBitMask,
                                              nodesToExclude: nodesToExclude)
    }
  }
}
