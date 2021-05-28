//
//  InstructionSelectViewController.swift
//  WalkThru
//
//  Created by user183837 on 5/27/21.
//

import UIKit

private let reuseIdentifier = "InstructionCell"

class InstructionSelectViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {
    var numInstructions = 1
    var instructionText = [" "]

    @IBOutlet weak var instructionCollection: UICollectionView!
    
    
    @IBSegueAction func arBackSegue(_ coder: NSCoder, sender: Any?) -> ARViewController? {
        return ARViewController(coder: coder)
    }
    @IBAction func arPressedSegue(sender: UIButton, forEvent event: UIEvent){
        
        performSegue(withIdentifier: "arBackSegue",
                   sender: sender)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numInstructions - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! InstructionSelectCollectionViewCell
        cell.nameLabel.text = "Step \(indexPath.row + 1). "
        cell.descrLabel.text = instructionText[indexPath.row + 1]
        cell.selectButton.tag = indexPath.row
        cell.selectButton.addTarget(self, action: #selector(arPressedSegue), for: .touchUpInside)
        // Configure the cell
    
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(numInstructions)
        print(instructionText[1])
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ARViewController {
            if let senderButton = sender as? UIButton{
                print(senderButton.tag)
                vc.stepNum = senderButton.tag - 1
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
