//
//  ViewController.swift
//  CloudKitTrip
//
//  Created by Mohsin on 09/11/2015.
//  Copyright © 2015 Mohsin. All rights reserved.
//

import UIKit
import CloudKit


@available(iOS 8.0, *)

class ViewController: UIViewController {


    var container : CKContainer = CKContainer.defaultContainer()
    var publicDB : CKDatabase!
    var privateDB : CKDatabase!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.publicDB = self.container.publicCloudDatabase
        self.privateDB = self.container.privateCloudDatabase
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func saveName(){
        // unique ID
        let nodeID = CKRecordID(recordName: "name1")
        
        let myRecord = CKRecord(recordType: "MyRecordType", recordID: nodeID)
        myRecord.setObject("Mohsin", forKey: "Name")
        
        self.publicDB.saveRecord(myRecord) { (record, error) -> Void in
            
            print("error : \(error)")
            let name = "Name"
            print("record : \(record?.valueForKey(name))")
        
        }
    
    }
    
    
    
    func fetchName(){
        
        
        let namePredicate  = NSPredicate(format: "Name = 'Mohsin'")
        let query = CKQuery(recordType: "MyRecordType", predicate: namePredicate)
        
        
        self.publicDB.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
            
            print("by query")
            print("error : \(error)")
            let name = "Name"
            print("record : \(records?[0].valueForKey(name))")
        }
        

        
        self.publicDB.fetchRecordWithID(CKRecordID(recordName: "name1")) { (record, error) -> Void in
            
            print("by recordID")
            print("error : \(error)")
            let name = "Name"
            print("record : \(record?.valueForKey(name))")
        }
        
    }
    
    
    @IBAction func save(sender: UIButton) {
        self.saveName()
        
    }
    
    
    @IBAction func fetch(sender: UIButton) {
         fetchName()
        
    }
    
    

}

