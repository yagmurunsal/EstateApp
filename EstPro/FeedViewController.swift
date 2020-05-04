//
//  FeedViewController.swift
//  EstPro
//
//  Created by Seçkin Onur Akarken on 24.04.2020.
//  Copyright © 2020 Yagmur Unsal. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var documentIdArray = [String]()
    var ilanNoArray = [String]()
    var titleArray = [String]()
    var estImageArray = [String]()
    var priceArray = [String]()
    var homeSizeArray = [String]()
    var districtArray = [String]()
    var cityArray = [String]()
    var heatingArray = [String]()
    var buildingAgeArray = [String]()
    var floorLocArray = [String]()
    var numberOfFloorArray = [String]()
    var balconyArray = [String]()
    var roomNumArray = [String]()
    var livingRoomArray = [String]()
    var bathroomArray = [String]()
    var documentIDArray = [String]()
    
    var selectedEstateId = ""
    var count = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
       
        // Do any additional setup after loading the view.
    }
    
  
    func getDataFromFirestore(){
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Estates").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.titleArray.removeAll(keepingCapacity: false)
                    self.balconyArray.removeAll(keepingCapacity: false)
                    self.buildingAgeArray.removeAll(keepingCapacity: false)
                    self.districtArray.removeAll(keepingCapacity: false)
                    self.floorLocArray.removeAll(keepingCapacity: false)
                    self.homeSizeArray.removeAll(keepingCapacity: false)
                    self.estImageArray.removeAll(keepingCapacity: false)
                    self.numberOfFloorArray.removeAll(keepingCapacity: false)
                    self.priceArray.removeAll(keepingCapacity: false)
                    self.cityArray.removeAll(keepingCapacity: false)
                    self.heatingArray.removeAll(keepingCapacity: false)
                    self.roomNumArray.removeAll(keepingCapacity: false)
                    self.documentIDArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let documentId = document.documentID
                        self.documentIDArray.append(documentId)
                        if let title = document.get("title") as? String{
                            self.titleArray.append(title)
                        }
                        if let district = document.get("district") as? String{
                            self.districtArray.append(district)
                        }
                       
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.estImageArray.append(imageUrl)
                        }
                       
                        if let price = document.get("price") as? String{
                            self.priceArray.append(price)
                        }
                        if let city = document.get("city") as? String{
                            self.cityArray.append(city)
                        }
                        if let homeSize = document.get("homeSize") as? String{
                            self.homeSizeArray.append(homeSize)
                        }
                        if let roomNum = document.get("roomNumber") as? String{
                            self.roomNumArray.append(roomNum)
                        }
                        if let bathroomNum = document.get("bathroomNum") as? String{
                            self.bathroomArray.append(bathroomNum)
                        }
                        if let buildingAge = document.get("buildingAge") as? String{
                            self.buildingAgeArray.append(buildingAge)
                        }
                        if let floorLocation = document.get("floorLocation") as? String{
                            self.floorLocArray.append(floorLocation)
                        }
                        if let numOfFloor = document.get("numberOfFloors") as? String{
                            self.numberOfFloorArray.append(numOfFloor)
                        }
                        if let heating = document.get("heating") as? String{
                            self.heatingArray.append(heating)
                        }
                        if let livingRoomNum = document.get("livingRoomNumber") as? String{
                            self.livingRoomArray.append(livingRoomNum)
                        }
                        if let ilanNo = document.get("ilanNo") as? String {
                            self.ilanNoArray.append(ilanNo)
                        }
            
                        
                    }
                    self.tableView.reloadData()
                }
               
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenPlaceId = selectedEstateId
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEstateId = documentIDArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.titleLabel.text = titleArray[indexPath.row].uppercased()
        cell.priceLabel.text = "Price: " + priceArray[indexPath.row] + " ₺"
        cell.districtLabel.text =  districtArray[indexPath.row] + "," + cityArray[indexPath.row]
        //cell.cityLabel.text = "City: " + cityArray[indexPath.row]
        cell.estImageView.sd_setImage(with: URL(string: self.estImageArray[indexPath.row]))
      
        return cell
    }



}
