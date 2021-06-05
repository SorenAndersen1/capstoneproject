//
//  libraryViewController.swift
//  multiIdentify
//
//  Created by user183837 on 5/11/21.
//

import UIKit

class libraryViewController: UIViewController {
    var buttonPressed:String = ""


    @IBSegueAction func arSegue(_ coder: NSCoder) -> ArViewController? {
        return ArViewController(coder: coder)
    }
    @IBAction func pbjSegue(_ sender: Any) {
        buttonPressed = "pbj"
        performSegue(withIdentifier: "arSegue",
                   sender: self)
    }
    @IBAction func cadooSegue(_ sender: Any) {
        buttonPressed = "cadoo"
        performSegue(withIdentifier: "arSegue",
                   sender: self)
    }
    @IBAction func airFilterSegue(_ sender: Any) {
        buttonPressed = "airFilter"
        performSegue(withIdentifier: "arSegue",
                   sender: self)
    }
    @IBSegueAction func airFilterARSegue(_ coder: NSCoder) -> ArViewController? {
        return ArViewController(coder: coder)
    }
    @IBSegueAction func createSegue(_ coder: NSCoder) -> UIViewController? {
        return UIViewController(coder: coder)
    }
    @IBOutlet weak var createButton: UIButton!

    @IBOutlet weak var pbj: UIView!
    @IBOutlet weak var cadoo: UIView!
    @IBOutlet weak var airFilter: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ArViewController {
            vc.hardCodeType = buttonPressed
        }
    }
}
            
