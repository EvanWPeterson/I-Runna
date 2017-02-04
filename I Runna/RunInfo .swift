//
//  RunInfo .swift
//  I Runna
//
//  Created by Evan Peterson on 1/25/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation
import CloudKit

class RunInfo {
    
    static let kRecordType = "RunInfo"
    var kRunName = "runName"
    var kRunLength = "runLength"
    var kRunTime = "runTime"
    var kDetailsOfRun = "detailsOfRun"
    var kRunLocation = "runLocation"
    
    var runName: String
    var runLength: Double
    var runTime: Date
    var detailsOfRun: String
    var runLocation: String
    
    var recordType: String { return "RunInfo" }
    var cloudKitRecordID: CKRecordID?
    
    init(runName: String, runLength: Double, runTime: Date, detailsOfRun: String, runLocation: String) {
        self.runName = runName
        self.runLength = runLength
        self.runTime = runTime
        self.detailsOfRun = detailsOfRun
        self.runLocation = runLocation
    }
    
    required init?(record: CKRecord) {
        guard let runName = record.value(forKey: kRunName) as? String,
        let runLength = record.value(forKey: kRunLength) as? Double,
        let runTime = record.value(forKey: kRunTime) as? Date,
            let detailsOfRun = record.value(forKey: kDetailsOfRun) as? String,
            let runLocation = record.value(forKey: kRunLocation) as? String else { return nil }
        
        self.runName = runName
        self.runLength = runLength
        self.runTime = runTime
        self.detailsOfRun = detailsOfRun
        self.runLocation = runLocation
        self.cloudKitRecordID = record.recordID
    }
    
}

extension CKRecord {
    convenience init(runInfo: RunInfo) {
        self.init(recordType: runInfo.recordType)
        
        self[runInfo.kRunName] = runInfo.runName as CKRecordValue?
        self[runInfo.kRunLength] = runInfo.runLength as CKRecordValue?
        self[runInfo.kRunTime] = runInfo.runTime as CKRecordValue?
        self[runInfo.kDetailsOfRun] = runInfo.detailsOfRun as CKRecordValue?
        self[runInfo.kRunLocation] = runInfo.runLocation as CKRecordValue?
        
    }
}
