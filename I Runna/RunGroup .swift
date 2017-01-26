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

class RunGroup {
    
    static let kRecordType = "RunGroup"
    let kPhotoURL = "PhotoURL"
    let kRunGroupName = "runGroupName"
    let kRunPace = "runPace"
    
    var runLogo: Data?
    var runGroupName: String
    //Double?
    var runPace: String
    
    var recordType: String { return "RunGroup" }
    var cloudKitRecordID: CKRecordID?
    
    
    fileprivate var temporaryPhotoURL: URL {
        let temporaryDirectory = NSTemporaryDirectory()
        let temporaryDirectoryURL = URL(fileURLWithPath: temporaryDirectory)
        let fileURL = temporaryDirectoryURL.appendingPathComponent(NSUUID().uuidString).appendingPathExtension("jpg")
        
        do {
            try runLogo?.write(to: fileURL)
        } catch {
            NSLog("Error writing photo data to file url: \(error.localizedDescription)")
        }
        return fileURL
    }
    
    
    var photo: UIImage {
        guard let data = runLogo, let image = UIImage(data: data) else { return UIImage() }
        return image
    }
    
    
    init(runLogo: Data, runGroupName: String, runPace: String) {
        self.runLogo = runLogo
        self.runGroupName = runGroupName
        self.runPace = runPace
    }
    
    required init?(record: CKRecord) {
        guard let picAsset = record.value(forKey: kPhotoURL) as? CKAsset,
        let runGroupString = record.value(forKey: kRunGroupName) as? String,
        let runPaceDouble = record.value(forKey: kRunPace) as? String else { return nil }
        
        self.runLogo = try? Data(contentsOf: picAsset.fileURL)
        self.runGroupName = runGroupString
        self.runPace = runPaceDouble
        self.cloudKitRecordID = record.recordID
        
    }
}

extension CKRecord {
    convenience init(runGroup: RunGroup) {
    self.init(recordType: runGroup.recordType)
        
        let asset = CKAsset(fileURL: runGroup.temporaryPhotoURL)
        self[runGroup.kPhotoURL] = asset
        self[runGroup.kRunPace] = runGroup.runPace as CKRecordValue?
        
    }
}
