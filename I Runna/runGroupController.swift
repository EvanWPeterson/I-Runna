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
    
    //Referencing and syncing
    
    
    static let postsChangedNotification = Notification.Name("PostsChangedNotification")
    static let runPostsChangedNotification = Notification.Name("RunPostsChangedNotification")
    
    static let sharedController = RunGroupController()
    
    var cloudKitManager = CloudKitManager()
    
//    var runInfo: [RunInfo] = []
    var runGroup: [RunGroup] = [] {
        didSet {
            DispatchQueue.main.async {
                let nc = NotificationCenter.default
                nc.post(name: RunGroupController.postsChangedNotification, object: self)
            }
        }
    }
    
    init() {
        fetchRun()
    }
    

    
    
    func createRunGroup(image: UIImage, name: String, pace: Double, location: String, rInfo: String) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
        let runGroup = RunGroup(runLogo: imageData, runGroupName: name, runPace: pace, runGroupLocation: location)
        
        let runRecord = CKRecord(runGroup: runGroup)
        self.runGroup.append(runGroup)
        cloudKitManager.saveRecord(runRecord) { (record, error) in
            if let error = error {
                print("Error saving run group to app: \(error)")
            }
        
        runGroup.cloudKitRecordID = record?.recordID
        }
    }
    
    func fetchRun() {
        
//        let sortDescriptor = NSSortDescriptor(key: RunGroup.kRecordType, ascending: false)
        
        
        cloudKitManager.fetchAllRecords(forType: RunGroup.kRecordType, sortDescriptors: []) { (records, error) in
            if let error = error {
                print("Error fetching records from CloudKit: \(error.localizedDescription)")
                
            }
            if let records = records {
                self.runGroup = records.flatMap { RunGroup(cloudKitRecord: $0) }
        
            }
        }
    }

}


