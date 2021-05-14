//
import Foundation
import UIKit
import SceneKit
import ARKit
import UIKit;

class ArViewController: UIViewController, ARSCNViewDelegate {
    var stepArrows = ["down": "ArrowDown",
                            "left": "ArrowLeft",
                            "right": "ArrowRight",
                            "up": "ArrowUp"]
    fileprivate let highlightMaskValue: Int = 2
    var infoList:[[ImageInfo]]!
    var MAX_STEP_NUM = 10 //Full amount of steps in process
    let MIN_STEP_NUM = 1 //Minimum Step number (Should probably be one)
    let MAX_IMAGES_USED = 4 //Largest number of pictures used in single step (Based on AR resource group)
    var stepNum = 1 //What Step User is on
    var stepList:[Step]!
    var timer:Timer?
    var timeLeft = [5,9]
    var hardCodeType:String = "" 

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var Instructions: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func nextStep(_ sender: Any) {
        stepNum += 1 //Go to next step
        if stepNum > MAX_STEP_NUM - 1{
            stepNum = MIN_STEP_NUM
        }
        sessionConfig() //restart AR session due to change in step
    }
    @IBAction func prevStep(_ sender: Any) {
        stepNum -= 1 //Go to next step
    
        if stepNum < MIN_STEP_NUM {
            stepNum = MAX_STEP_NUM - 1
        }
        sessionConfig() //restart AR session due to change in step
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true

        stepList = stepSetup(MAX_STEP_NUM: MAX_STEP_NUM) //init steplist
        let floatHoldr = Float(stepNum / (MAX_STEP_NUM - 1))
        progressBar.setProgress(floatHoldr, animated: false)
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
        
        progressBar.setProgress(Float(stepNum) / Float(MAX_STEP_NUM - 1), animated: true)


    }

    
    func stepSetup(MAX_STEP_NUM: Int ) -> [Step]{
        var stepARR:[Step] = [Step]() //setup dummy Step array
        
        //get Instruction set list from the class

        if let instructionText = createInstructionText(filename: hardCodeType){
        self.MAX_STEP_NUM = instructionText.instruction.count
        for n in 0...self.MAX_STEP_NUM - 1{
            stepARR.append(Step(identityNum: n, instruction: "\(n). " +  (instructionText.getInstruction(numDesired: n)), successInstruct: "\(n). " + (instructionText.getsuccessInstruct(numDesired: n)), hardCodeType: hardCodeType)) //assign step values to each step in the array
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
                let imgNum = compareName(name: objName ?? "error")

            
                let textCheck = infoList[stepNum][imgNum].appearText
                let nameCheck = infoList[stepNum][imgNum].imgName
                let arrowCheck = infoList[stepNum][imgNum].arrowDir
                var highlighCheck = infoList[stepNum][imgNum].highLightColor

                let array = highlighCheck.components(separatedBy: "_")
                
                highlighCheck = array[0]
                let shapeCheck = array[1]
            
                if(nameCheck == objName){
                    let widthHoldr = Float(imageAnchor.referenceImage.physicalSize.width)
                    let heightHoldr = Float(imageAnchor.referenceImage.physicalSize.height)

                    if(textCheck == "none"){
                        print("No text found")
                    }
                    else{
                        node.addChildNode(addNameNode(textCheck: textCheck, widthHoldr: widthHoldr)) //add node to list of nodes being used
                    }
                    if(arrowCheck != "Unknown"){
                        node.addChildNode(addArrowNode(arrowName: arrowCheck, widthOfObject: imageAnchor.referenceImage.physicalSize.width, heightOfObject: imageAnchor.referenceImage.physicalSize.height))
                    }
                    if(highlighCheck != "none"){
                        node.addChildNode(addPlaneNode(shapeCheck: shapeCheck, widthOfObject: imageAnchor.referenceImage.physicalSize.width, heightOfObject: imageAnchor.referenceImage.physicalSize.height, highlighCheck: highlighCheck))
                    }
                    else if(shapeCheck == "airFilter"){
                        let specialPlanes = addSpecialPlaneNode(shapeCheck: shapeCheck, widthOfObject: imageAnchor.referenceImage.physicalSize.width, heightOfObject: imageAnchor.referenceImage.physicalSize.height, highlighCheck: highlighCheck)
                        for planes in specialPlanes {
                            node.addChildNode(planes)
                        }

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
    func addNameNode(textCheck: String, widthHoldr: Float) -> SCNNode {
        let text = SCNText(string: textCheck, extrusionDepth: 2)
            //setup text value to be used in AR image
        let material = SCNMaterial() //set material
        material.diffuse.contents = UIColor.white //text color = BLUE
        text.materials = [material] //add material (text color) to the node's material list
        
        let Textnode = SCNNode() //create new node to place text at
        Textnode.position = SCNVector3(x: 0.0, y:0.0, z:-0.075)
        Textnode.scale = SCNVector3(x: 0.005, y:0.005, z:-0.005)
        Textnode.geometry = text
        return Textnode
    }
    


func addArrowNode(arrowName: String, widthOfObject: CGFloat, heightOfObject: CGFloat) -> SCNNode {
    let image = UIImage(named: stepArrows[arrowName] ?? "")
        let rotImg = image?.imageByMakingWhiteBackgroundTransparent()
        let Imgnode = SCNNode(geometry: SCNPlane(width: widthOfObject * 0.32, height: heightOfObject * 0.5))
    Imgnode.position = SCNVector3(x:0.0, y:0.06, z: Float(heightOfObject) * 0.65 )
        Imgnode.geometry?.firstMaterial?.diffuse.contents = rotImg

        return Imgnode
    }

func addPlaneNode(shapeCheck: String, widthOfObject: CGFloat, heightOfObject: CGFloat, highlighCheck: String) -> SCNNode {
        var choosenSize = SCNPlane(width:  widthOfObject * 0.80 , height: heightOfObject * 0.80)
                                            
        switch shapeCheck {
        case "full":
            choosenSize = SCNPlane(width:  widthOfObject * 0.95 , height: heightOfObject * 0.95)
        case "circle":
            choosenSize = SCNPlane(width:  widthOfObject * 0.80 , height: heightOfObject * 0.80)
            choosenSize.cornerRadius =  widthOfObject

        default:
            choosenSize = SCNPlane(width:  widthOfObject * 0.80 , height: heightOfObject * 0.80)
        }
    
    let plane = choosenSize
    var colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 1.0) /* #00ea07 */
    
        switch highlighCheck {
        case "green":
            colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 0.85) /* #00ea07 */
        case "red":
            colorChoosen = UIColor(hue: 0.0056, saturation: 1, brightness: 0.82, alpha: 0.85) /* #d10600 */
        default:
            colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 0.95) /* #00ea07 */
        }
    
    
    plane.firstMaterial?.diffuse.contents = colorChoosen
    let planeNode = SCNNode(geometry: plane)
    
    planeNode.eulerAngles.x = -.pi / 2
                                            
        return planeNode
    }



    func addSpecialPlaneNode(shapeCheck: String, widthOfObject: CGFloat, heightOfObject: CGFloat, highlighCheck: String) -> [SCNNode] {
        var specialPlaneArr = [SCNNode]()

    switch shapeCheck {
        case "corners":
            var holdr = [SCNPlane]()
            let hardcoded = [SCNVector3(x:0.127, y:-0.006, z:-0.013), SCNVector3(x:0.127, y:-0.05, z:0.026), SCNVector3(x:-0.127, y:-0.05, z:0.013)]
            for _ in 0...2 {
                let airFilterPlane = SCNPlane(width: widthOfObject * 0.30 , height: heightOfObject * 0.30)
                airFilterPlane.firstMaterial?.diffuse.contents = UIColor(hue: 0.0056, saturation: 1, brightness: 0.82, alpha: 0.9) /* #d10600 */
                holdr.append(airFilterPlane)

            }
            for i in 0...holdr.count - 1 {
                let airFilterNode = SCNNode(geometry: holdr[i])
                airFilterNode.position = hardcoded[i]
                airFilterNode.eulerAngles.x = -.pi / 2
                
                specialPlaneArr.append(airFilterNode)
            }
        case "left":
            let airFilterPlane = SCNPlane(width: widthOfObject * 0.40 , height: heightOfObject * 0.70)
            airFilterPlane.firstMaterial?.diffuse.contents = UIColor(hue: 0.0056, saturation: 1, brightness: 0.82, alpha: 0.9) /* #d10600 */
            let airFilterNode = SCNNode(geometry: airFilterPlane)
            airFilterNode.position = SCNVector3(x:-0.110, y:-0.06, z:-0.013)
            airFilterNode.eulerAngles.x = -.pi / 2
       specialPlaneArr.append(airFilterNode)
        
         default:
        
            let airFilterPlane = SCNPlane(width: widthOfObject * 1.0 , height: heightOfObject * 1.0)
            airFilterPlane.firstMaterial?.diffuse.contents = UIColor(hue: 1.0, saturation: 1, brightness: 0.82, alpha: 0.9) /* #d10600 */
            let airFilterNode = SCNNode(geometry: airFilterPlane)
            airFilterNode.position = SCNVector3(x:0.0, y:0.0, z:0.0)
            airFilterNode.eulerAngles.x = -.pi / 2
             specialPlaneArr.append(airFilterNode)
                            }
        return specialPlaneArr
    }
    func compareName(name: String) -> Int {
        var doubleIT = 0
         var i = 0
         repeat{
            let nameCheck = infoList[stepNum][i].imgName
                 if(nameCheck == name){
                     doubleIT = i
                     break
                 }
                 else{
                 i = i + 1
                 }
 
         }while i < infoList[stepNum].count - 1
        return doubleIT
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
