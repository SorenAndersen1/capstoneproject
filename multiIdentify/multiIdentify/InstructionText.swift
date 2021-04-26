//
//  InstructionText.swift
//  multiIdentify
//
//  Created by user183837 on 3/29/21.
//
import Foundation

///Class representing a full instruction set
class InstructionText{
    var instruction = [String]()
    var infos = [[ImageInfo]]()
    var successInstruct = [String]()
    
    init(){
    }

    func instructForLoop(instructArr: [String]){
        for n in 0...instructArr.count - 1{
            self.instruction.append(instructArr[n])
        }
    }
    
    func createAndAppendInfos(appearText: [String], arrowDir: [String], imgName: [String], highlightedColor: [String]){
        var fullImage = [ImageInfo]()
        for n in 0...appearText.count - 1 {
            fullImage.append(ImageInfo(appearText: appearText[n], arrowDir: arrowDir[n], imgName: imgName[n], highlightColor: highlightedColor[n]))
            
        }
        
        self.infos.append(fullImage)
    }
    
    func getsuccessInstruct(numDesired: Int) -> String {

            return self.successInstruct[numDesired]


    }
    func getInstruction(numDesired: Int) -> String {

            return self.instruction[numDesired]
    }
    
    func getInfo(numDesired: Int) -> [ImageInfo] {
        return self.infos[numDesired]
    }
    
    func getInfos() -> [[ImageInfo]] {
        return self.infos
    }
    
    func appendInstructionText(text: String){
        self.instruction.append(text)

    }
    
    func appendSuccessText(text: String){
        self.successInstruct.append(text)

    }

}
