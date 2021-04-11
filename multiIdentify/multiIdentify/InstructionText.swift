//
//  InstructionText.swift
//  multiIdentify
//
//  Created by user183837 on 3/29/21.
//
import Foundation

class InstructionText{
    var instruction = [String]()
    var infos = [[ImageInfo]]()
    var successInstruct = [String()]
    
    init( hardCodeType: String) {
        //these are going to hardcoded for the mac and cheese, but can easily be refactored to allow for another func
            if(hardCodeType == "airFilter"){
                //This is for the entire proccess
                let instructionTextArr = [
                "You Should never see this one",
                "Identify hood",
                "Identify air filter",
                "Snap open obvious clips on the bottom and top right",
                "Snap open clip under left cord",
                "Pry back lid to left",
                "Take out old air filter",
                "Place new air filter in highlighted hole",
                    "Close lid and snap on obvious clips",
                    "Snap close clip under the left hose",
                    "Close hood"]
                let successinstructionTextArr = [
                    "You Should never see this one",
                    "Open car hood",
                    "Air filter found",
                    "One clip remaining",
                    "All clips released",
                    "Used air filter",
                    "Place aside for now",
                    "Ensure air filter is flush",
                        "3 clips snapped",
                        "All clips snapped",
                        "Great job! You are safe to drive!"]
                if(successinstructionTextArr.count == instructionTextArr.count){
                    self.successInstruct = successinstructionTextArr
                    self.instruction = instructionTextArr
                }
                
                
                
                var appearTextArr = ["test",
                                     "test"]
                var arrowDirArr = ["test", "test"]
                var imgNameArr = ["test", "test"]
                var highlightedColorArr = ["test", "test"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))

                //Step 1 of Replacing Kia Air Filter
                appearTextArr = ["Open hood"]
                arrowDirArr = ["up"]
                imgNameArr = ["kiaHood"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 2 of Replacing Kia Air Filter
                appearTextArr = ["Found Air Filter"]
                arrowDirArr = ["down"]
                imgNameArr = ["Air Filter"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 3 of Replacing Kia Air Filter
                appearTextArr = ["Snap clips"]
                arrowDirArr = ["Unknown"]
                imgNameArr = ["Air Filter_"]
                highlightedColorArr = ["red_corners"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 4 of Replacing Kia Air Filter
                appearTextArr = ["Snap final clip", "Below this cord"]
                arrowDirArr = ["Unknown", "down"]
                imgNameArr = ["airfilter_full3", "cord"]
                highlightedColorArr = ["red_left", "green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 5 of Replacing Kia Air Filter
                appearTextArr = ["Reveal air filter"]
                arrowDirArr = ["left"]
                imgNameArr = ["airfilter_raw"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 6 of Replacing Kia Air Filter
                appearTextArr = ["Remove", "Place here"]
                arrowDirArr = ["Unknown", "down"]
                imgNameArr = ["airFilter", "airfilter_hole"]
                highlightedColorArr = ["green_full", "red_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))

                //Step 7 of Replacing Kia Air Filter
                appearTextArr = ["New Air filter"]
                arrowDirArr = ["Unknown"]
                imgNameArr = ["airfilter_raw3"]
                highlightedColorArr = ["none_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 8 of Replacing Kia Air Filter
                appearTextArr = ["Close hood"]
                arrowDirArr = ["down"]
                imgNameArr = ["kiaHood1"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
            }
            else if(hardCodeType == "pbj"){
                //This is for the entire proccess
                let instructionTextArr = [
                "You Should never see this one",
                "Identify Bread",
                "Take 2 slices of bread out, identify one",
                "Open Peanutbutter and Jelly out",
                "Use knife to spread evenly on each slice of bread",
                "Take peanutbutter spread side and place on top of jelly side",
                "Grab sandwich bags",
                "Place sandwich inside of bag"]
                let successinstructionTextArr = [
                    "You Should never see this one",
                    "Delicious bread, good choice!",
                    "Bread in spreadable position",
                    "Spreads readied",
                    "Spreads applied",
                    "Sandwich constructed, good job!",
                    "Open bag using zipper",
                    "Congrats you have lunch!"]
      
                    self.successInstruct = successinstructionTextArr
                    self.instruction = instructionTextArr
                
                
                
                
                var appearTextArr = ["test",
                                     "test"]
                var arrowDirArr = ["test", "test"]
                var imgNameArr = ["test", "test"]
                var highlightedColorArr = ["test", "test"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))

                //Step 1 of making PBJ
                appearTextArr = ["Open Bread"]
                arrowDirArr = ["Unknown"]
                imgNameArr = ["breadbag"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 2 of making PBJ
                appearTextArr = ["Place bread"]
                arrowDirArr = ["down"]
                imgNameArr = ["bread"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 3 of making PBJ
                appearTextArr = ["Spin Lid right", "Open Jar", "Open Jar", "Spin Lid Right"]
                arrowDirArr = ["right", "down", "down", "right"]
                imgNameArr = ["canLid", "jamJar", "pb", "pbLid"]
                highlightedColorArr = ["red_circle", "red_full", "green_full", "green_circle"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                
                //Step 4 of making PBJ
                appearTextArr = ["Jam spread", "PB spread"]
                arrowDirArr = ["Unknown", "Unknown"]
                imgNameArr = ["pbBread", "jam_boread"]
                highlightedColorArr = ["red_full", "green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 5 of making PBJ
                appearTextArr = ["Finished sandwich"]
                arrowDirArr = ["Unknown"]
                imgNameArr = ["sandwich"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 6 of making PBJ
                appearTextArr = ["Take Out Bag"]
                arrowDirArr = ["Unknown"]
                imgNameArr = ["ziploc"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 7 of making PBJ
                appearTextArr = ["Complete sandwich!"]
                arrowDirArr = ["down"]
                imgNameArr = ["bagged"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
            }
            else if(hardCodeType == "cadoo"){
                //This is for the entire proccess
                let instructionTextArr = [
                "You Should never see this one",
                "Identify box",
                "Identify board",
                "Fold board out so circle side is visible",
                "Take notepads out and set on oppisites side of the board",                "Remove all 4 sets of pieces and place one each side of gameboard",
                    "Take boxes of cards reading 'Solo' and 'Combo' out",
                "Remove timer and clay and place die in the middle",
                "If highlighted the board is set up"]
                let successinstructionTextArr = [
                    "You Should never see this one",
                    "Cadoo Deluxe Edition",
                    "Place board on table",
                    "Board correctly positioned",
                    "Notepads found",
                    "Pieces in position",
                    "Card boxes found",
                    "Assorted pieces ready",
                    "Congrats! Have fun playing Cadoo!"]
                if(successinstructionTextArr.count == instructionTextArr.count){
                    self.successInstruct = successinstructionTextArr
                    self.instruction = instructionTextArr
                }
                
                
                
                var appearTextArr = ["test",
                                     "test"]
                var arrowDirArr = ["test", "test"]
                var imgNameArr = ["test", "test"]
                var highlightedColorArr = ["test", "test"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 1 of Setting Up Cadoo
                appearTextArr = ["Cadoo Box"]
                arrowDirArr = ["down"]
                imgNameArr = ["cadooBox"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 2 of Setting Up Cadoo
                appearTextArr = ["Fold out"]
                arrowDirArr = ["right"]
                imgNameArr = ["foldOut"]
                highlightedColorArr = ["red_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 3 of Setting Up Cadoo
                appearTextArr = ["Full Board"]
                arrowDirArr = ["down"]
                imgNameArr = ["board"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                
                //Step 4 of Setting Up Cadoo
                appearTextArr = ["Full Board", "Notepad", "Notepad"]
                arrowDirArr = ["down", "Unknown", "Unknown"]
                imgNameArr = ["board1", "notepad1", "notepad2"]
                highlightedColorArr = ["green_full",
                                       "green_full",
                                       "green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 5 of Setting Up Cadoo
                appearTextArr = ["Full Board", "Pieces still in", "Pieces Placed"]
                arrowDirArr = ["down", "Unknown", "Unknown"]
                imgNameArr = ["board2", "emptierBox", "semiFullbox"]
                highlightedColorArr = ["green_full",
                                       "green_full",
                                       "red_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 6 of Setting Up Cadoo
                appearTextArr = ["Combo Cards", "Solo Cards"]
                arrowDirArr = ["Unknown", "Unknown"]
                imgNameArr = ["combo", "solo"]
                highlightedColorArr = ["green_full",
                                       "green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 7 of Setting Up Cadoo
                appearTextArr = ["Clay", "Empty box", "Glasses"]
                arrowDirArr = ["Unknown", "Unknown", "Unknown"]
                imgNameArr = ["clay", "emptyBox", "glasses"]
                highlightedColorArr = ["green_full",
                                       "green_full",
                                       "green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
                
                //Step 8 of Setting Up Cadoo
                appearTextArr = ["Finished Board!"]
                arrowDirArr = ["down"]
                imgNameArr = ["board_and_dice"]
                highlightedColorArr = ["green_full"]
                self.infos.append(appendInfo(appearText: appearTextArr, arrowDir: arrowDirArr, imgName: imgNameArr, highlightedColor: highlightedColorArr))
            }
            }
        
        

    func instructForLoop(instructArr: [String]){
        for n in 0...instructArr.count - 1{
            self.instruction.append(instructArr[n])
        }
    }
    func appendInfo(appearText: [String], arrowDir: [String], imgName: [String], highlightedColor: [String]) -> [ImageInfo] {
        var fullImage = [ImageInfo]()
        for n in 0...appearText.count - 1 {
            fullImage.append(ImageInfo(appearText: appearText[n], arrowDir: arrowDir[n], imgName: imgName[n], highlightColor: highlightedColor[n]))
            
        }
        
        return fullImage
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

}
