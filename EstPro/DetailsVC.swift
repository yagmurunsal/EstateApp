//
//  DetailsVC.swift
//  EstPro
//
//  Created by Seçkin Onur Akarken on 26.04.2020.
//  Copyright © 2020 Yagmur Unsal. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import Cosmos
import TinyConstraints
class DetailsVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var homeSizeText: UILabel!
    @IBOutlet weak var roomNumText: UILabel!
    @IBOutlet weak var bathroomNumText: UILabel!
    @IBOutlet weak var balconyText: UILabel!
    @IBOutlet weak var buildingAge: UILabel!
    @IBOutlet weak var floorLocation: UILabel!
    @IBOutlet weak var numberOfFloorsText: UILabel!
    @IBOutlet weak var heatingText: UILabel!
    @IBOutlet weak var districtText: UILabel!
    @IBOutlet weak var cityText: UILabel!
    @IBOutlet weak var cosmosRating: CosmosView!
    
    var chosenPlaceId = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(chosenPlaceId)
        getInfoFromFirestore()
        cosmosRating.didFinishTouchingCosmos = { rating in
            print(rating)
            self.createRatingsFunc( cosmosRatingg : rating )
            self.cosmosRating.rating = rating
        }
    }
    func createRatingsFunc ( cosmosRatingg : Double ) -> Void {
        let firestoreDatabase = Firestore.firestore()
        var firestoreReference:DocumentReference? = nil
        let firestoreRate = ["documentID" : chosenPlaceId , "ratedUser" : Auth.auth().currentUser!.email! , "rating" : cosmosRatingg ] as [String : Any]
        firestoreReference = firestoreDatabase.collection("RatingCollection").addDocument(data: firestoreRate, completion: { (error) in
            if error != nil{
                self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
            }
        })
    }
    func getInfoFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Estates").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents{
                        if document.documentID  == self.chosenPlaceId  {
                            self.titleText.text = (document.get("title") as? String)?.uppercased()
                            self.priceText.text = "Price : "  + (document.get("price")  as? String)! + " ₺"
                            self.homeSizeText.text = "Home Size: "  + (document.get("homeSize") as? String)! + " m²"
                            
                            self.roomNumText.text = "Room : "  + (document.get("roomNumber") as? String)! + " + " + (document.get("livingRoomNumber") as? String)!
                            self.bathroomNumText.text = "Bathroom: "  + (document.get("bathroomNum") as? String)!
                            self.balconyText.text = "Balcony: "  + (document.get("balcony") as? String)!
                            self.buildingAge.text = "Building Age: "  + (document.get("buildingAge") as? String)!
                            self.floorLocation.text = "Floor Location: "  + (document.get("floorLocation") as? String)!
                            self.numberOfFloorsText.text = "Number of Floors: "  + (document.get("numberOfFloors") as? String)!
                            self.heatingText.text = "Heating Type: "  + (document.get("heating") as? String)!
                            self.districtText.text = "District: "  + (document.get("district") as? String)!
                            self.cityText.text = "City: "  + (document.get("city") as? String)!
                            self.imageView.sd_setImage(with: URL(string: (document.get("imageUrl") as? String)! ))
                            fireStoreDatabase.collection("RatingCollection").addSnapshotListener { (snapshot, error) in
                                      if error != nil{
                                      print(error?.localizedDescription as Any)
                                      }else{
                                          if snapshot?.isEmpty != true && snapshot != nil {
                                              for documentRatings in snapshot!.documents{
                                                  if self.chosenPlaceId == documentRatings.get("documentID") as? String && Auth.auth().currentUser?.email! == documentRatings.get("ratedUser") as? String{
                                                    self.cosmosRating.rating = (documentRatings.get("rating") as? Double)! 
                                                  }
                                              }}
                                      }
                                      
                                  }
                        }
                        
                    }
                }
            }
        }
    }
    
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput,message: messageInput,preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK" , style: UIAlertAction.Style.default,handler:nil )
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}
