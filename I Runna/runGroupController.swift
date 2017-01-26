//
//  runGroupController.swift
//  I Runna
//
//  Created by Evan Peterson on 1/25/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class runGroupController {
    
    static var sharedController = runGroupController()
    
    var runGroup: [RunGroup] = []
    
    var cloudKitManager = CloudKitManager()
    
    // Chage pace to Double???
    func createRunGroup(image: UIImage, name: String, pace: String) {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else { return }
        let rgName = RunGroup(runLogo: imageData, runGroupName: "", runPace: "")
        
        let runRecord = CKRecord(runGroup: rgName)
        cloudKitManager.saveRecord(runRecord) { (record, error) in
            if let error = error {
                print("Error saving run group to app: \(error)")
            }
        rgName.cloudKitRecordID = record?.recordID
        self.runGroup.append(rgName)
            
        }
    }
    
    func syncedRecords(type: String) -> [CLoudKitSyncable] {
        var records: [CLoudKitSyncable] = []
        runGroup.forEach { (run) in
            if run.cloudKitRecordID != nil { records.append(run as! CLoudKitSyncable) }
//            run.runGroupName.forEach { (rgName) in
//                if runGroupName.cloudKitRecordID != nil { records.append(rgName) }
//                }
//            }
    }
        return records

}
    // Forced unwrap
    func unsyncedRecords(type: String) -> [CLoudKitSyncable] {
        var records: [CLoudKitSyncable] = []
        runGroup.forEach { (run) in
            if run.cloudKitRecordID != nil { records.append(run as! CLoudKitSyncable) }
        }
        return records
        
    }
    
    
    func fetchNewRecords(type: String, completion: @escaping ((Error?) -> Void) = {_ in}) {
        
    }


    func pushChangeToCloudkit() {
        
    }
    
    func performFullSync() {
        
    }
    
    func deleteRunGroup() {
        
    }
}
