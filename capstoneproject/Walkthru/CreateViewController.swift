//
//  CreateViewController.swift
//  WalkThru
//
//  Created by user183837 on 5/13/21.
//

import UIKit

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var typeCreate:Int = -1
    @IBAction func typePressed(sender: UIButton, forEvent event: UIEvent){
        typeCreate = sender.tag
        sender.isSelected = !sender.isSelected;
    }
    @IBAction func nextPress(sender: UIButton, forEvent event: UIEvent){
        if(typeCreate == -1){
            let alert = UIAlertController(title: "Type not found", message: "Try Again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
        }
        else{
            //THIS IS WHERE IMAGE SELECTION GOES
        }
    }
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var modifyButton: UIButton!
    @IBOutlet weak var repairButton: UIButton!
    @IBOutlet weak var replaceButton: UIButton!
    @IBOutlet weak var recipeButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeButton.addTarget(self, action: #selector(typePressed), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(typePressed), for: .touchUpInside)
        modifyButton.addTarget(self, action: #selector(typePressed), for: .touchUpInside)
        repairButton.addTarget(self, action: #selector(typePressed), for: .touchUpInside)
        replaceButton.addTarget(self, action: #selector(typePressed), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPress), for: .touchUpInside)
        // Do any additional setup after loading the view.
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
