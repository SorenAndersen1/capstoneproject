//
//  instructionText.swift
//  mac_and_cheese
//
//  Created by user183837 on 2/25/21.
//

import Foundation

class InstructionText{
    var instruction = [String]()
    var infos = [ImageInfo?]()
    
    init( hardCodeType: String) {
        //these are going to hardcoded for the mac and cheese, but can easily be refactored to allow for another func
            if(hardCodeType == "macAndCheese"){
                self.instruction.append("This should not appear")
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
            
                self.infos.append(nil)
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "Place Pot", arrowDir: "Down", imgName: "burner"))
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "6 cups water", arrowDir: "Down", imgName: "water_pot"))
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "Open", arrowDir: "Down", imgName: "anniesBoxFront"))
                self.infos.append(ImageInfo(appearText: "Open", arrowDir: "Down", imgName: "back_box"))
                
                self.infos.append(ImageInfo(appearText: "Take Cheese", arrowDir: "Up", imgName: "box_cheese"))
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "Wait until Boiling", arrowDir: "Unknown", imgName: "boiling_water"))
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "Pour Pasta in", arrowDir: "Down", imgName: "boiling_water"))
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "Place in Sink", arrowDir: "Down", imgName: "colander_empty"))
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "Slowly Tip into Colander", arrowDir: "Left", imgName: "pasta_pot"))
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "Shake!", arrowDir: "Up", imgName: "colander_pasta"))
                self.infos.append(nil)
                
                self.infos.append(ImageInfo(appearText: "Rip Open", arrowDir: "Right", imgName: "cheese_pack"))
                self.infos.append(ImageInfo(appearText: "Splash In", arrowDir: "Down", imgName: "milk"))
                
                self.infos.append(ImageInfo(appearText: "Done!", arrowDir: "Unknown", imgName: "finished_mac"))
                self.infos.append(nil)
                
                self.infos.append(nil)
                self.infos.append(nil)
                
            }
        
    }
    func getInstruction(numDesired: Int) -> String {
        return self.instruction[numDesired]
    }
    
    func getInfos() -> [ImageInfo?] {
        return self.infos
    }
}
