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

class RunGroupController {
    
    static let sharedController = RunGroupController()
    
    var runGroup: [RunGroup] = []
    
    var cloudKitManager = CloudKitManager()
    
    // Chage pace to Double???
    func createRunGroup(image: UIImage, name: String, pace: String, location: String) {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else { return }
        let rgName = RunGroup(runLogo: imageData, runGroupName: name, runPace: pace, runGroupLocation: location)
        
        let runRecord = CKRecord(runGroup: rgName)
        self.runGroup.append(rgName)
        cloudKitManager.saveRecord(runRecord) { (record, error) in
            if let error = error {
                print("Error saving run group to app: \(error)")
            }
        rgName.cloudKitRecordID = record?.recordID
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
