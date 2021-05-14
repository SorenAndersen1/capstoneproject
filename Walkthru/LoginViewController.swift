//
//  LoginViewController.swift
//  multiIdentify
//
//  Created by user183837 on 5/11/21.
//
import UIKit
import Foundation
//import Parse

class LoginViewController: UIViewController {
    var passwordList: [String]  = ["nowlen", "soren", "claire"]
    var usernameList: [String]  = ["webbjos", "andesore", "swanscol"]


    @IBAction func signUpClick(_ sender: Any) {
        if ( usernameList.contains(usernameText.text ?? "andesore") == false && passwordText.text != nil ){
            usernameList.append(usernameText.text ?? "error")
            passwordList.append(passwordText.text ?? "error")
        }
        else{
            let alert = UIAlertController(title: "Sign up Failed", message: "Please try again.", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var usernameText: UITextField!
    
    @IBSegueAction func login(_ coder: NSCoder) -> libraryViewController? {
        return libraryViewController(coder: coder)
    }
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    @IBAction func loginButton(_ sender: Any) {
        let userIndex = usernameList.lastIndex(of: usernameText.text ?? "none")
        let passwordIndex = passwordList.lastIndex(of: passwordText.text ?? "none")
        if ( userIndex == passwordIndex && passwordIndex != nil ){

            performSegue(withIdentifier: "librarySegue", sender: sender)
            }
        else{
            let alert = UIAlertController(title: "Log in Failed", message: "Please try again.", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBSegueAction func tempSegue(_ coder: NSCoder) -> libraryViewController? {
        return libraryViewController(coder: coder)
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
    /*
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameText.text
        newUser.password = passwordText.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    func loginUser() {

       let username = usernameText.text ?? ""
       let password = passwordText.text ?? ""

       PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
              print("User log in failed: \(error.localizedDescription)")
            } else {
              print("User logged in successfully")
                self.performSegue(withIdentifier: "librarySegue", sender: username)
                
            }
         }
    }
 */
}

