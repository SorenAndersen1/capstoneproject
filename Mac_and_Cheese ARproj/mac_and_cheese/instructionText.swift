//
//  instructionText.swift
//  mac_and_cheese
//
//  Created by user183837 on 2/25/21.
//

import Foundation

class InstructionText{
    var instruction = [String]()
    
    init( hardCodeType: String) {
        //these are going to hardcoded for the mac and cheese, but can easily be refactored to allow for another func
            if(hardCodeType == "macAndCheese"){
                self.instruction.append("This is the first instruction")
                self.instruction.append("This is the second instruction")
                self.instruction.append("This is the third instruction")
                self.instruction.append("This is the fourth instruction")
                self.instruction.append("This is the fifth instruction")
                self.instruction.append("This is the sixth instruction")
                self.instruction.append("This is the seventh instruction")
            }
        
    }
    func getInstruction(numDesired: Int) -> String {
        return self.instruction[numDesired]
    }
}
