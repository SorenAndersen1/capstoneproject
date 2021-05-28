//
import Foundation
import UIKit
import SceneKit
import ARKit
import UIKit;

class ARViewController: UIViewController, ARSCNViewDelegate {
    var stepArrows = ["down": "ArrowDown",
                            "left": "ArrowLeft",
                            "right": "ArrowRight",
                            "up": "ArrowUp"]
    fileprivate let highlightMaskValue: Int = 2
    var infoList:[[ImageInfo]]!
    var MAX_STEP_NUM = 10 //Full amount of steps in process
    let MIN_STEP_NUM = 1 //Minimum Step number (Should probably be one)
    let MAX_IMAGES_USED = 6 //Largest number of pictures used in single step (Based on AR resource group)
    var stepNum = 1 //What Step User is on
    var stepList:[Step]!
    var timer:Timer?
    var timeLeft = [5,9]
    var hardCodeType:String = "" 
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var Instructions: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func instructSelect(sender: Any, forEvent event: UIEvent){
        performSegue(withIdentifier: "instructionSegue",
                   sender: sender)
    }
    @IBSegueAction func instructionSegue(_ coder: NSCoder) -> InstructionSelectViewController? {
        return InstructionSelectViewController(coder: coder)
    }
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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Once Everything is loaded in this func runs
        // Create a session configuration
        let floatHoldr = Float(stepNum / (MAX_STEP_NUM - 1))
        progressBar.setProgress(floatHoldr, animated: false)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(instructSelect))
        Instructions.isUserInteractionEnabled = true
        Instructions.addGestureRecognizer(tap)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? InstructionSelectViewController {
                //print(senderButton.tag)
            for text in 1...MAX_STEP_NUM - 1 {
                vc.instructionText.append(stepList[text].instruction)
            }
               vc.numInstructions = MAX_STEP_NUM
            
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
                    else if(shapeCheck == "special"){
                        let specialPlanes = addSpecialCordNode(shapeCheck: shapeCheck, widthOfObject: imageAnchor.referenceImage.physicalSize.width, heightOfObject: imageAnchor.referenceImage.physicalSize.height, highlighCheck: highlighCheck, specialCords: infoList[stepNum][imgNum].specialCordinates, planeMod: infoList[stepNum][imgNum].planeModifiers)
                        for planes in specialPlanes {
                            node.addChildNode(planes)
                        }

                    }
                    else{
                        node.addChildNode(addPlaneNode(shapeCheck: "blank", widthOfObject: imageAnchor.referenceImage.physicalSize.width, heightOfObject: imageAnchor.referenceImage.physicalSize.height, highlighCheck: "blank"))
                        
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
        Textnode.position = SCNVector3(x:-widthHoldr * 0.5, y:0.075, z:-0.0)
        Textnode.scale = SCNVector3(x: 0.005, y:0.005, z:-0.005)
        Textnode.geometry = text
        Textnode.eulerAngles.x = .pi / 8
        return Textnode
    }
    


func addArrowNode(arrowName: String, widthOfObject: CGFloat, heightOfObject: CGFloat) -> SCNNode {
    let image = UIImage(named: stepArrows[arrowName] ?? "")
        let rotImg = image?.imageByMakingWhiteBackgroundTransparent()
        let Imgnode = SCNNode(geometry: SCNPlane(width: widthOfObject * 0.32, height: heightOfObject * 0.5))
    Imgnode.position = SCNVector3(x:0.0, y:Float(heightOfObject) * 0.65 , z:0.06 )
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
        case "blank":
            choosenSize = SCNPlane(width:  widthOfObject * 0.80 , height: heightOfObject * 0.80)
        case "left":
            choosenSize = SCNPlane(width: widthOfObject * 0.40 , height: heightOfObject * 0.40)
        case "right":
            choosenSize = SCNPlane(width: widthOfObject * 0.40 , height: heightOfObject * 0.90)
        default:
            choosenSize = SCNPlane(width:  widthOfObject * 0.80 , height: heightOfObject * 0.80)
        }
    
    let plane = choosenSize

    plane.firstMaterial?.diffuse.contents = colorChoice(highlightCheck: highlighCheck)
    let planeNode = SCNNode(geometry: plane)
    
    planeNode.eulerAngles.x = -.pi / 2
                                            
        return planeNode
    }

    func colorChoice(highlightCheck: String) -> UIColor {
        var colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 1.0) /* #00ea07 */
        
            switch highlightCheck {
            case "green":
                colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 0.85) /* #00ea07 */
            case "red":
                colorChoosen = UIColor(hue: 0.0056, saturation: 1, brightness: 0.82, alpha: 0.85) /* #d10600 */
            case "blank":
                colorChoosen = UIColor(hue: 0.0056, saturation: 1, brightness: 0.1, alpha: 0.1) /* #d10600 */
            default:
                colorChoosen = UIColor(hue: 0.3389, saturation: 1, brightness: 0.92, alpha: 0.95) /* #00ea07 */
            }
        return colorChoosen
    }
    func addSpecialCordNode(shapeCheck: String, widthOfObject: CGFloat, heightOfObject: CGFloat, highlighCheck: String, specialCords: [Float], planeMod: [Float]) -> [SCNNode] {
        var specialPlaneArr = [SCNNode]()
        var planeArr = [SCNPlane]()
        var vectorArr = [SCNVector3]()
        
            for n in 0...(specialCords.count / 2) - 1 {
                let specialVec = SCNVector3(x: specialCords[n], y:specialCords[n + 1], z: specialCords[n + 2])
                vectorArr.append(specialVec)
            }

        for _ in 0...vectorArr.count - 1 {
            let airFilterPlane = SCNPlane(width: widthOfObject * CGFloat(planeMod[0]) , height: heightOfObject * CGFloat(planeMod[1]))
            airFilterPlane.firstMaterial?.diffuse.contents = colorChoice(highlightCheck: highlighCheck)
            planeArr.append(airFilterPlane)

        }
        for i in 0...planeArr.count - 1 {
            let specialNode = SCNNode(geometry: planeArr[i])
            specialNode.position = vectorArr[i]
            specialNode.eulerAngles.x = -.pi / 2
            
            specialPlaneArr.append(specialNode)
        }
        return specialPlaneArr
    }
    func addSpecialPlaneNode(shapeCheck: String, widthOfObject: CGFloat, heightOfObject: CGFloat, highlighCheck: String) -> [SCNNode] {
        var specialPlaneArr = [SCNNode]()

    switch shapeCheck {
        case "corners":
            var holdr = [SCNPlane]()
            let hardcoded = [SCNVector3(x:0.127, y:-0.0, z:-0.127), SCNVector3(x:0.115, y:0.0, z:0.127), SCNVector3(x:-0.119, y:0.0, z:0.127)]
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
            let airFilterPlane = SCNPlane(width: 0.335 * 0.40 , height: heightOfObject * 0.40)
            airFilterPlane.firstMaterial?.diffuse.contents = UIColor(hue: 0.0056, saturation: 1, brightness: 0.82, alpha: 0.9) /* #d10600 */
            let airFilterNode = SCNNode(geometry: airFilterPlane)
            airFilterNode.position = SCNVector3(x:-0.110, y:-0.0, z:-0.06)
            airFilterNode.eulerAngles.x = -.pi / 2
       specialPlaneArr.append(airFilterNode)
        case "right":
            let airFilterPlane = SCNPlane(width: 0.335 * 0.40 , height: heightOfObject * 0.90)
            airFilterPlane.firstMaterial?.diffuse.contents = UIColor(hue: 0.0056, saturation: 1, brightness: 0.82, alpha: 0.9) /* #d10600 */
            let airFilterNode = SCNNode(geometry: airFilterPlane)
            airFilterNode.position = SCNVector3(x:0.127, y:-0.0, z:-0.0)
            airFilterNode.eulerAngles.x = -.pi / 2
       specialPlaneArr.append(airFilterNode)
            

        case "cardinal":
            let colorArr = [UIColor(hue: 0.8, saturation: 0.85, brightness: 0.94, alpha: 1.0), UIColor(hue: 0.2472, saturation: 1, brightness: 0.77, alpha: 1.0), UIColor(hue: 0.0917, saturation: 1, brightness: 0.97, alpha: 1.0), UIColor(hue: 0.5472, saturation: 1, brightness: 0.99, alpha: 1.0)]
            var holdr = [SCNPlane]()
            let hardcoded = [SCNVector3(x:0.284, y:-0.0, z:0.0), SCNVector3(x:0.0, y:0.0, z:(0.284)), SCNVector3(x:0.0, y:0.0, z:-0.284), SCNVector3(x:-0.284, y:0.0, z:0.0)]
            for i in 0...hardcoded.count - 1 {
                let airFilterPlane = SCNPlane(width: widthOfObject * 0.30 , height: heightOfObject * 0.30)
                airFilterPlane.firstMaterial?.diffuse.contents = colorArr[i]
                holdr.append(airFilterPlane)

            }
            for i in 0...holdr.count - 1 {
                let airFilterNode = SCNNode(geometry: holdr[i])
                airFilterNode.position = hardcoded[i]
                airFilterNode.eulerAngles.x = -.pi / 2
                
                specialPlaneArr.append(airFilterNode)
            }
        case "corner":

            var holdr = [SCNPlane]()
     
            let airFilterPlane = SCNPlane(width: widthOfObject * 0.30 , height: heightOfObject * 0.30)
            airFilterPlane.firstMaterial?.diffuse.contents = UIColor(hue: 0.2472, saturation: 1, brightness: 0.77, alpha: 1.0)
            holdr.append(airFilterPlane)
            let airFilterNode = SCNNode(geometry: airFilterPlane)
            airFilterNode.position = SCNVector3(x:0.248, y:-0.01, z:0.248)
            airFilterNode.eulerAngles.x = -.pi / 2
            specialPlaneArr.append(airFilterNode)
            
            let cornerPlane = SCNPlane(width: widthOfObject * 0.30 , height: heightOfObject * 0.30)
            cornerPlane.firstMaterial?.diffuse.contents = UIColor(hue: 0.5472, saturation: 1, brightness: 0.99, alpha: 1.0)
            holdr.append(cornerPlane)
            let cornerNode = SCNNode(geometry: cornerPlane)
            cornerNode.position = SCNVector3(x:-0.2485, y:-0.01, z:-0.248)
            cornerNode.eulerAngles.x = -.pi / 2
            specialPlaneArr.append(cornerNode)
        case "box":
            let colorArr = [
               UIColor(hue: 0.7694, saturation: 1, brightness: 0.71, alpha: 1.0),
               UIColor(hue: 0.9972, saturation: 1, brightness: 0.93, alpha: 1.0)]
            var holdr = [SCNPlane]()
            
            let hardcoded = [SCNVector3(x:-0.213, y:0.0, z:0.1065), SCNVector3(x:0.213, y:0.0, z:0.1065)]



            for i in 0...1 {
                let airFilterPlane = SCNPlane(width: widthOfObject * 0.20 , height: heightOfObject * 0.20)
                airFilterPlane.firstMaterial?.diffuse.contents = colorArr[i]
                holdr.append(airFilterPlane)

        }
        
        for i in 0...holdr.count - 1 {
            let airFilterNode = SCNNode(geometry: holdr[i])
            airFilterNode.position = hardcoded[i]
            airFilterNode.eulerAngles.x = -.pi / 2
            
            specialPlaneArr.append(airFilterNode)
        }
    case "misc":
        let airFilterPlane = SCNPlane(width: widthOfObject * 0.4 , height: heightOfObject * 0.7)
        airFilterPlane.firstMaterial?.diffuse.contents = UIColor(hue: 0.6139, saturation: 1, brightness: 1.0, alpha: 1.0)
        let airFilterNode = SCNNode(geometry: airFilterPlane)
        airFilterNode.position = SCNVector3(x:-0.27, y:-0.0, z:-0.06)
        airFilterNode.eulerAngles.x = -.pi / 2
        specialPlaneArr.append(airFilterNode)
    case "plate":
        let colorArr = [
            UIColor(hue: 0.7694, saturation: 1, brightness: 0.71, alpha: 0.0),
            UIColor(hue: 0.9972, saturation: 1, brightness: 0.93, alpha: 0.9)]
        var holdr = [SCNPlane]()
        
        let hardcoded = [SCNVector3(x:0.0, y:0.0, z:0.11), SCNVector3(x:0.0, y:0.0, z:-0.11)]



        for i in 0...1 {
            let airFilterPlane = SCNPlane(width: widthOfObject * 0.350 , height: heightOfObject * 0.20)
            airFilterPlane.firstMaterial?.diffuse.contents = colorArr[i]
            holdr.append(airFilterPlane)

    }
    
    for i in 0...holdr.count - 1 {
        let airFilterNode = SCNNode(geometry: holdr[i])
        airFilterNode.position = hardcoded[i]
        airFilterNode.eulerAngles.x = -.pi / 2
        
        specialPlaneArr.append(airFilterNode)
    }
    default:
        
            let airFilterPlane = SCNPlane(width: widthOfObject * 0.4 , height: heightOfObject * 0.7)
            airFilterPlane.firstMaterial?.diffuse.contents = UIColor(hue: 0.6139, saturation: 1, brightness: 0, alpha: 1.0)
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
