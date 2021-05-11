//
//  LoginViewController.swift
//  multiIdentify
//
//  Created by user183837 on 5/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBSegueAction func loginSegue(_ coder: NSCoder) -> UIViewController? {
        return UIViewController(coder: coder)
    }
    @IBOutlet weak var ForwardButton: UIButton!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBAction func onFowardButton(_ sender: Any){
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
