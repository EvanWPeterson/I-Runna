//
//  RunController.swift
//  I Runna
//
//  Created by Evan Peterson on 2/1/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation
import CloudKit

class RunInfoController {
    
    static let sharedController = RunInfoController()
    
    var runInfo: [RunInfo] = []
    
    var cloudKitManager = CloudKitManager()
    
    func createRun(dateTime: Date, runLength: Double, runName: String, runLocation: String, runDetails: String) {
        let rInfo = RunInfo(runName: runName, runLength: runLength, runTime: dateTime, detailsOfRun: runDetails, runLocation: runLocation)
        
        self.runInfo.append(rInfo)
    }
    
    func syncedRecords() {
        
    }
    
    func unsyncedRecords() {
        
    }
    
    func fetchNewRecords() {
        
    }
    
    func pushChangeToCloudKit() {
        
    }
    
    func performFullSync() {
        
    }
    
    func deleteRun() {
        
    }
    
    
    
}
