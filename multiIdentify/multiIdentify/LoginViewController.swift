//
//  LoginViewController.swift
//  multiIdentify
//
//  Created by user183837 on 5/11/21.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var usernameText: UITextField!
    
    @IBSegueAction func login(_ coder: NSCoder) -> libraryViewController? {
        return libraryViewController(coder: coder)
    }
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!


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
