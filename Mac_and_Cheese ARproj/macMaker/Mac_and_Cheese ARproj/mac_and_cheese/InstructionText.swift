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
                self.instruction.append("Take out 8in pot and turn on large burner to medium-high")
                self.instruction.append("Fill pot with 6 cups of water")
                self.instruction.append("Take Annies Mac and Cheese out and open top")
                self.instruction.append("Take cheese packet out of box")
                self.instruction.append("Wait until water is boiling")
                self.instruction.append("Pour pasta in water and wait for timer to expire")
                self.instruction.append("Place colander in sink ")
                self.instruction.append("Slowly tip pot into colander draining all water")
                self.instruction.append("Shake colander 3 times, then place pasta back into pot")
                self.instruction.append("Rip top of Cheese pack spreading evenly throughout pasta, splash milk in")
                self.instruction.append("Place finished product in bowl")
            }
        
    }
    func getInstruction(numDesired: Int) -> String {
        return self.instruction[numDesired]
    }
}
