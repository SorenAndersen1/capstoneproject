//
//  Step.swift
//  mac_and_cheese
//
//  Created by user183837 on 2/25/21.
//
//Step Class
import Foundation
class Step {
    let identityNum: Int
    let arResourceName: String
    var instruction: String
    
    init(identityNum: Int, instruction: String) {
        self.identityNum = identityNum
        self.arResourceName = "\(identityNum)_Step" //AR RESOURCE FILES HAVE TO BE IN THIS FORMAT
        self.instruction = instruction
    }
    func setInstruction(instruction: String){
        self.instruction = instruction
    }

}
