
import Foundation

let fakeTextConst = "This should never appear"

struct InstructionsData : Decodable {
    var instructions : [InstInfo]
}

struct InstInfo : Decodable {
    var instructionText : String
    var successText : String
    var itemInfos : [ItemInfo]

}

struct ItemInfo : Decodable {
    var appearText: String
    var arrowDir: String
    var imgName: String
    var highlightColor: String
}

///Creates an array of InstInfo respresenting the data in the provided json file
///
///- parameter filename : Name of the json file
///
func loadJson(filename fileName: String) -> [InstInfo]? {
    
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json", subdirectory: "InstructionSets") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(InstructionsData.self, from: data)
            return jsonData.instructions
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

///Creates an instruction text from a json file with the provided filename
///
/// - parameter filename : The name of the json file to create instructions from
///
func createInstructionText(filename fileName: String) -> InstructionText?{
    //Get the JSON data
    let rawData = loadJson(filename: fileName)
    var newText = InstructionText()
    
    if let rawData = loadJson(filename: fileName){
        //Apply our placeholder values
        //TODO - refactor to no longer need these
        newText.appendInstructionText(text: fakeTextConst)
        newText.appendSuccessText(text: fakeTextConst)
        newText.createAndAppendInfos(appearText: [fakeTextConst], arrowDir: [fakeTextConst], imgName: [fakeTextConst], highlightedColor: [fakeTextConst])
        let num = rawData.count
        
        //Iterate over all steps
        for n in 0...num - 1{
            newText.appendInstructionText(text: rawData[n].instructionText)
            newText.appendSuccessText(text: rawData[n].successText)
            let numInfos = rawData[n].itemInfos.count
            var appearText = [String](), arrowDir = [String](),
                imgName = [String](), highlightedColor = [String]()
            
            //Iterate over all image infos in the step
            for j in 0...numInfos - 1{
                appearText.append(rawData[n].itemInfos[j].appearText)
                arrowDir.append(rawData[n].itemInfos[j].arrowDir)
                imgName.append(rawData[n].itemInfos[j].imgName)
                highlightedColor.append(rawData[n].itemInfos[j].highlightColor)
               
            }
            
            newText.createAndAppendInfos(appearText: appearText, arrowDir: arrowDir, imgName: imgName, highlightedColor: highlightedColor)
        }
      return newText
    }
    
    
    return nil
}
