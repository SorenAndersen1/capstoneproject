//
import Foundation
import UIKit
import SceneKit
import ARKit
import UIKit;

class ViewController: UIViewController, ARSCNViewDelegate {
    @objc func prevStep(_ sender: Any) {
        // stepNum -= 1 //Go to Previous Step
       //  if stepNum < MIN_STEP_NUM {
        //     stepNum = MAX_STEP_NUM - 1
        // }
         sessionConfig() //restart AR session due to change in step
     }
     
     @objc func nextStep(_ sender: Any) {
        // stepNum += 1 //Go to next step
        // if stepNum > MAX_STEP_NUM - 1{
        //     stepNum = MIN_STEP_NUM
        // }
         sessionConfig() //restart AR session due to change in step
     }
    
    var stepArrows = ["down": "ArrowDown",
                            "left": "ArrowLeft",
                            "right": "ArrowRight",
                            "up": "ArrowUp"]
    fileprivate let highlightMaskValue: Int = 2
    var infoList:[[ImageInfo]]!

    @IBAction func nextsStep(_ sender: Any) {
        stepNum += 1 //Go to next step
        if stepNum > MAX_STEP_NUM - 1{
            stepNum = MIN_STEP_NUM
        }
        sessionConfig() //restart AR session due to change in step
    }

    @IBAction func prevsStep(_ sender: Any) {
    stepNum -= 1 //Go to Previous Step
    if stepNum < MIN_STEP_NUM {
        stepNum = MAX_STEP_NUM - 1
    }
    sessionConfig() //restart AR session due to change in step
}
    @IBOutlet weak var Instructions: UILabel!
    
    @IBOutlet var sceneView: ARSCNView!

    @IBOutlet weak var timeLabel: UILabel!
    var MAX_STEP_NUM = 8 //Full amount of steps in process
    let MIN_STEP_NUM = 1 //Minimum Step number (Should probably be one)
    let MAX_IMAGES_USED = 4 //Largest number of pictures used in single step (Based on AR resource group)
    var stepNum = 1 //What Step User is on
    var stepList:[Step]!
    var timer:Timer?
    var timeLeft = [5,9]
    var hardCodeType:String = ""
    



    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
        hardCodeType = "cadoo"

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
        var NextStep = ARReferenceImage.referenceImages(inGroupNamed: "1_Step_pbj", bundle: Bundle.main)
        configuration.maximumNumberOfTrackedImages = MAX_IMAGES_USED;
        
        Instructions.text = stepList[stepNum].instruction
        NextStep = ARReferenceImage.referenceImages(inGroupNamed: stepList[stepNum].arResourceName, bundle: Bundle.main)
 
        configuration.detectionImages = NextStep //set session to newly selected folder
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors]) //reset all image recongition and anchors,
    }

    
    func stepSetup(MAX_STEP_NUM: Int ) -> [Step]{
        var stepARR:[Step] = [Step]() //setup dummy Step array
        if let instructionText = createInstructionText(filename: hardCodeType){
            //InstructionText(hardCodeType: hardCodeType) //get Instruction set list from the class
        self.MAX_STEP_NUM = instructionText.instruction.count
        for n in 0...self.MAX_STEP_NUM - 1{
            stepARR.append(Step(identityNum: n, instruction: "\(n). " +  (instructionText.getInstruction(numDesired: n)), successInstruct: (instructionText.getsuccessInstruct(numDesired: n)), hardCodeType: hardCodeType)) //assign step values to each step in the array
        }
        infoList = instructionText.getInfos()
        }

        
        return stepARR //Send the newly made array to the didViewLoad func to allow for usage throughout funcs
    }
    @objc func onTimerFires()
    {
 

        timeLeft[stepNum - 5] -= 1
        timeLabel.text = "\(timeLeft[stepNum - 5])) Minutes Left"

        if(timeLeft[stepNum - 5] == 1){
            timeLabel.text = "\(timeLeft[stepNum - 5])) Minutes Left"

        }

        if  timeLeft[stepNum - 5] <= 0 || (stepNum < 5 || stepNum > 6){
            Instructions.text = stepList[stepNum].successInstruct
            timer?.invalidate()
            timer = nil
            timeLabel.isHidden = true;//hide timer text
            timeLeft = [5,9]
        }
    }
      
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }



    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        
        
        if let imageAnchor = anchor as? ARImageAnchor {
            Instructions.text = stepList[stepNum].successInstruct

            //Where animations take place, set to display text name of image currently
                    /* https://medium.com/s23nyc-tech/arkit-planes-3d-text-and-hit-detection-1e10335493d
                */

                    let objName = imageAnchor.referenceImage.name //set string value to picture file name of recongized image
           // let currentInfos = infoList[stepNum]
           var doubleIT = 0
            var i = 0
            repeat{
                let nameCheck = infoList[stepNum][i].imgName
                    if(nameCheck == objName){
                        doubleIT = i
                        break
                    }
                    else{
                    i = i + 1
                    }
    
            }while i < infoList[stepNum].count - 1

            
                let textCheck = infoList[stepNum][doubleIT].appearText
                let nameCheck = infoList[stepNum][doubleIT].imgName
                let arrowCheck = infoList[stepNum][doubleIT].arrowDir
                var highlighCheck = infoList[stepNum][doubleIT].highLightColor

                let array = highlighCheck.components(separatedBy: "_")
                
                highlighCheck = array[0]
                let shapeCheck = array[1]
            
                if(nameCheck == objName){


                    let text = SCNText(string: textCheck, extrusionDepth: 2)
                        //setup text value to be used in AR image
                    let material = SCNMaterial() //set material
                    material.diffuse.contents = UIColor.white //text color = BLUE
                    text.materials = [material] //add material (text color) to the node's material list
                    
                    let Textnode = SCNNode() //create new node to place text at
                Textnode.position = SCNVector3(x:0.0, y:0.00, z:-0.075)

                    Textnode.scale = SCNVector3(x:0.005, y:0.005, z:-0.005)
                    Textnode.geometry = text
                    Textnode.eulerAngles.x = -.pi / 2
                    node.addChildNode(Textnode) //add node to list of nodes being used
        
                    if(arrowCheck != "Unknown"){
                        let image = UIImage(named: stepArrows[arrowCheck] ?? "")
                    let rotImg = image?.imageByMakingWhiteBackgroundTransparent()
                        let Imgnode = SCNNode(geometry: SCNPlane(width: imageAnchor.referenceImage.physicalSize.width / 2, height: imageAnchor.referenceImage.physicalSize.height / 2))
                            Imgnode.position = SCNVector3(x:0.0, y:0.05, z:-0.11)
                            Imgnode.geometry?.firstMaterial?.diffuse.contents = rotImg

                            node.addChildNode(Imgnode)
                
                    }
                
                    if(highlighCheck != "none"){
                        
                                            
                                       
                                          
                                            var choosenSize = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width * 0.80 , height: imageAnchor.referenceImage.physicalSize.height * 0.80)
                                            
                                                switch shapeCheck {
                                                case "full":
                                                    choosenSize = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width * 0.90 , height: imageAnchor.referenceImage.physicalSize.height * 0.90)
                                                case "circle":
                                                    choosenSize = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width * 0.80 , height: imageAnchor.referenceImage.physicalSize.height * 0.80)
                                                    choosenSize.cornerRadius = imageAnchor.referenceImage.physicalSize.width
                                                default:
                                                    choosenSize = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width * 0.80 , height: imageAnchor.referenceImage.physicalSize.height * 0.80)
                                                }
                                            
                                            let plane = choosenSize
                                            var colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 1.0) /* #00ea07 */
                                            
                                                switch highlighCheck {
                                                case "green":
                                                    colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 0.5) /* #00ea07 */
                                                case "red":
                                                    colorChoosen = UIColor(hue: 0.0056, saturation: 1, brightness: 0.82, alpha: 0.5) /* #d10600 */
                                                default:
                                                    colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 0.5) /* #00ea07 */
                                                }
                                            
                                            
                                            plane.firstMaterial?.diffuse.contents = colorChoosen
                                            let planeNode = SCNNode(geometry: plane)
                                            
                                            planeNode.eulerAngles.x = -.pi / 2
                                            
                                            node.addChildNode(planeNode)

                            
                                
                                    
                    }

                }
                else{
                    print("Error")
                }
        
        //node.setCategoryBitMaskForAllHierarchy(highlightMaskValue)

        
    }
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

@IBDesignable extension UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

}

@IBDesignable extension UILabel {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }

}
