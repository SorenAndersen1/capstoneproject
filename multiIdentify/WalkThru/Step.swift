//
//  Step.swift
//  mac_and_cheese
//
//  Created by user183837 on 2/25/21.
//
import Foundation
class Step {
    let identityNum: Int
    let arResourceName: String
    var instruction: String
    var successInstruct: String
    var hardCodeType: String
    
    init(identityNum: Int, instruction: String, successInstruct: String, hardCodeType: String) {
        self.hardCodeType = hardCodeType
        self.identityNum = identityNum
        self.arResourceName = "\(identityNum)_Step_\(hardCodeType)" //AR RESOURCE FILES HAVE TO BE IN THIS FORMAT
        self.instruction = instruction
        self.successInstruct = successInstruct
    }
    func setInstruction(instruction: String){
        self.instruction = instruction
    }
    func setSuccessInstruct(instruction: String){
        self.successInstruct = instruction
    }
}

class ImageInfo {
    let appearText: String
    let arrowDir: String
    let imgName: String
    var highLightColor: String
    
    init(appearText: String, arrowDir: String, imgName: String, highlightColor: String){
        self.appearText = appearText
        self.arrowDir = arrowDir
        self.imgName = imgName
        self.highLightColor = highlightColor
    }
    
    func sethighLightColor(highLightColor: String){
        self.highLightColor = highLightColor
    }
}
