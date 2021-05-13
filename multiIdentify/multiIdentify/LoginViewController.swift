//
//  LoginViewController.swift
//  multiIdentify
//
//  Created by user183837 on 5/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    var passwordList: [String]  = ["nowlen", "soren", "claire"]
    var usernameList: [String]  = ["webbjos", "andesore", "swanscol"]


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
            self.showToast(message: "Error logging in", font: .systemFont(ofSize: 12.0))
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

}
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
