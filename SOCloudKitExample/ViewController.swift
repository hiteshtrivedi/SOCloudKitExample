//
//  ViewController.swift
//  SOCloudKitExample
//
//  Created by Hitesh on 9/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtRecodFeed: UITextField!
    
    // Fetch Public Database
    let publicDB = CKContainer.defaultContainer().publicCloudDatabase
    let recordID = CKRecordID(recordName: "Student")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        publicDB.fetchRecordWithID(recordID) { fetchedStudent, error in
            let name = CKRecord(recordType: "attendence", recordID: self.recordID)
            name["name"] = "Jhon"
            
            self.publicDB.saveRecord(name) { savedRecord, error in
                // handle errors here
                print(savedRecord, error)
                
                if error == nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        let name = savedRecord!["name"] as? String
                        self.txtRecodFeed?.text = name
                    }
                } else {
                    print(error?.code)
                    if error?.code == 14 {
                        self.fetchUserRecordByID()
                    }
                }
            }
        }
    }
    
    
    func fetchUserRecordByID() {
        publicDB.fetchRecordWithID(recordID) { savedRecord, error in
            // handle errors here
            if error == nil {
                dispatch_async(dispatch_get_main_queue()) {
                    let name = savedRecord!["name"] as? String
                    self.txtRecodFeed?.text = name
                }
            }
            print(savedRecord, error)
        }
    }
    
    
    @IBAction func actionUpdate(sender: AnyObject) {
        publicDB.fetchRecordWithID(recordID) { fetchedStudent, error in
            guard let fetchedStudent = fetchedStudent else {
                // handle errors here
                return
            }
            
            if self.txtRecodFeed.text?.characters.count != 0 {
                fetchedStudent["name"] = self.txtRecodFeed.text
            } else {
                return
            }
            
            self.publicDB.saveRecord(fetchedStudent) { savedRecord, savedError in
                print(savedRecord, error)
            }
        }
    }
    
    
    
    @IBAction func checkUpdate(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

