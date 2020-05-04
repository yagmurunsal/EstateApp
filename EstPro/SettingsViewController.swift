//
//  SettingsViewController.swift
//  EstPro
//
//  Created by Seçkin Onur Akarken on 24.04.2020.
//  Copyright © 2020 Yagmur Unsal. All rights reserved.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch {
            print("error")
        }
       
    }
    
}
