//
//  ViewController.swift
//  Dicee
//
//  Created by Angela Yu on 25/01/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//




import UIKit

//
//  ViewController.swift
//  ARKitVisionObjectDetection
//
//  Created by Dennis Ippel on 08/07/2020.
//  Copyright © 2020 Rozengain. All rights reserved.
//

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    var pickedImage = false

    override func viewDidAppear(_ animated: Bool) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) && !pickedImage {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            pickedImage = true
        }
    }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    print("cancelled")
        self.dismiss(animated: true, completion: nil)
   }
//

    //I cannot figure out why this is not working
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            //save image
//            //display image
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){


            imageView.image = image
        print("selected");
            self.dismiss(animated: true, completion: { () -> Void in
            })

    }
//    @IBOutlet weak var diceImageView1: UIImageView!
//    @IBOutlet weak var diceImageView2: UIImageView!
//
//
//    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6", ]
//
//
//
//    var randomDiceIndex1 : Int = 0
//    var randomDiceIndex2 : Int = 0
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//
//
//    func updateDiceImages() {
//
//
//        randomDiceIndex1 = Int(arc4random_uniform(6))
//        randomDiceIndex2 = Int(arc4random_uniform(6))
//
//        print(randomDiceIndex1)
//
//        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
//        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
//
//    }
//
//
//
//
//
//    @IBAction func rollButtonPressed(_ sender: UIButton) {
//        updateDiceImages()
//    }
//
//
//
//
//
//    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//
//            updateDiceImages()
//
//
//        }
//
//    }
    
    
    
    


}
