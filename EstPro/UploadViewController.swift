//
//  UploadViewController.swift
//  EstPro
//
//  Created by Seçkin Onur Akarken on 24.04.2020.
//  Copyright © 2020 Yagmur Unsal. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController {

    @IBOutlet weak var ilanNoText: UITextField!
    @IBOutlet weak var imageUrlText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var homeSizeText: UITextField!
    @IBOutlet weak var roomNumText: UITextField!
    @IBOutlet weak var livingRoomNumText: UITextField!
    @IBOutlet weak var buildingAgeText: UITextField!
    @IBOutlet weak var floorLocationText: UITextField!
    @IBOutlet weak var numberOfFloorText: UITextField!
    @IBOutlet weak var bathroomNumText: UITextField!
    @IBOutlet weak var balconyText: UITextField!
    @IBOutlet weak var heatingText: UITextField!
    @IBOutlet weak var districtText: UITextField!
    @IBOutlet weak var cityText: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func uploadClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        
        var firestoreReference:DocumentReference? = nil
        
        let firestoreEstate = ["ilanNo": ilanNoText.text! ,"imageUrl" : imageUrlText.text! , "title" : titleText.text! ,"price" : priceText.text! ,"homeSize" : homeSizeText.text! ,"roomNumber": roomNumText.text!,"livingRoomNumber" : livingRoomNumText.text!,"buildingAge": buildingAgeText.text! , "floorLocation" : floorLocationText.text!, "numberOfFloors": numberOfFloorText.text! ,"bathroomNum" : bathroomNumText.text! ,"balcony": balconyText.text!,"heating" : heatingText.text!, "district" : districtText.text!, "city": cityText.text! ] as [String:Any]
        
        firestoreReference = firestoreDatabase.collection("Estates").addDocument(data: firestoreEstate, completion: { (error) in
            if error != nil{
                self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
            }
        })
    }
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput,message: messageInput,preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK" , style: UIAlertAction.Style.default,handler:nil )
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
   

}
