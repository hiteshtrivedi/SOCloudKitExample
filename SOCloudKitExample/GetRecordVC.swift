//
//  GetRecordVC.swift
//  SOCloudKitExample
//
//  Created by Hitesh on 9/3/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit
import CloudKit

class GetRecordVC: UIViewController {
    
    @IBOutlet weak var lblShowData: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let recordID = CKRecordID(recordName: "Student")
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        
        publicDB.fetchRecordWithID(recordID) { savedRecord, error in
            // handle errors here
            if error == nil {
                dispatch_async(dispatch_get_main_queue()) {
                let name = savedRecord!["name"] as? String
                self.lblShowData?.text = name
                }
            }
            print(savedRecord, error)
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
