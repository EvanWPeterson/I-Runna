//
//  RunGroup .swift
//  I Runna
//
//  Created by Evan Peterson on 1/25/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class RunGroup: SearchableRecord {
    
    static let kRecordType = "RunGroup"
    static let kPhotoURL = "PhotoURL"
    static let kRunGroupName = "runGroupName"
    static let kRunPace = "runPace"
    static let kRunGroupLocation = "runGroupLocation"
    static let kRunInfo = "runInfo"

    
    var runLogo: Data?
    var runGroupName: String
    var runPace: Double
    var runGroupLocation: String
    var runGroup: [RunGroup] = []
    
    var cloudKitRecordID: CKRecordID?
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: RunGroup.kRecordType)
        
        record[RunGroup.kPhotoURL] = runLogo as CKRecordValue?
        record[RunGroup.kRunGroupName] = runGroupName as CKRecordValue?
        record[RunGroup.kRunPace] = runPace as CKRecordValue?
        record[RunGroup.kRunGroupLocation] = runGroupLocation as CKRecordValue?
        
        
        
        return record
    }
    
    var photo: UIImage {
        guard let data = runLogo, let image = UIImage(data: data) else { return UIImage() }
        return image
    }
    
        var temporaryPhotoURL: URL {
        let temporaryDirectory = NSTemporaryDirectory()
        let temporaryDirectoryURL = URL(fileURLWithPath: temporaryDirectory)
        let fileURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        
            try? runLogo?.write(to: fileURL)
    
        return fileURL
    }

    
    
    init(runLogo: Data, runGroupName: String, runPace: Double, runGroupLocation: String) {
        self.runLogo = runLogo
        self.runGroupName = runGroupName
        self.runPace = runPace
        self.runGroupLocation = runGroupLocation
    }
    
      init?(cloudKitRecord: CKRecord) {
        guard let picAsset = cloudKitRecord[RunGroup.kPhotoURL] as? CKAsset,
        let runLogo = try? Data(contentsOf: picAsset.fileURL),
        let runGroupName = cloudKitRecord[RunGroup.kRunGroupName] as? String,
        let runPaceDouble = cloudKitRecord[RunGroup.kRunPace] as? Double,
        let runLocation = cloudKitRecord[RunGroup.kRunGroupLocation] as? String,
        cloudKitRecord.recordType == RunGroup.kRecordType else { return nil }
        
        self.runLogo = try? Data(contentsOf: picAsset.fileURL)
        self.runGroupName = runGroupName
        self.runPace = runPaceDouble
        self.runGroupLocation = runLocation
        self.runLogo = runLogo
        
    }
    
    func matchesSearchTerm(searchTerm: String) -> Bool {
        for runGroup in self.runGroup {
            if runGroup.runGroupName.lowercased().contains(searchTerm.lowercased()) { return true }
        }
        return false
        }
    
    var recordType: String { return RunGroup.kRecordType }
    
}

extension CKRecord {
    convenience init(runGroup: RunGroup) {
        let recordID = CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: runGroup.recordType, recordID: recordID)
        
        let asset = CKAsset(fileURL: runGroup.temporaryPhotoURL)
        self[RunGroup.kPhotoURL] = asset as CKRecordValue?
        self[RunGroup.kRunPace] = runGroup.runPace as CKRecordValue?
        self[RunGroup.kRunGroupLocation] = runGroup.runGroupLocation as CKRecordValue?
        self[RunGroup.kRunGroupName] = runGroup.runGroupName as CKRecordValue?
        
    }
}
