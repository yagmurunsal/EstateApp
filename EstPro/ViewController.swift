//
//  ViewController.swift
//  EstPro
//
//  Created by Seçkin Onur Akarken on 24.04.2020.
//  Copyright © 2020 Yagmur Unsal. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var emailTextF: UITextField!
    
    @IBOutlet weak var passwordTextF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailTextF.text != "" && passwordTextF.text != "" {
            Auth.auth().signIn(withEmail: emailTextF.text!, password: passwordTextF.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput:"Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                     self.performSegue(withIdentifier: "toFeedVC" , sender: nil)
                }
            }
        }else{
            makeAlert(titleInput:"Error", messageInput: "Username/Password")
        }
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
       if emailTextF.text != "" && passwordTextF.text != ""{
                  Auth.auth().createUser(withEmail: emailTextF.text!, password: passwordTextF.text!) { (authdata, error) in
                      if error != nil{
                         self.makeAlert(titleInput:"Error", messageInput: error?.localizedDescription ?? "Error")
                      }else{
                          self.performSegue(withIdentifier: "toFeedVC" , sender: nil)
                      }
                  }
                  
                  
              }
              else{
                  makeAlert(titleInput:"Error", messageInput: "Username/Password")
              }
        
    }
    
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput,message: messageInput,preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK" , style: UIAlertAction.Style.default,handler:nil )
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}
