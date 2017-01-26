//
//  CloudKitSyncable .swift
//  I Runna
//
//  Created by Evan Peterson on 1/25/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import Foundation
import CloudKit

protocol CLoudKitSyncable {
    init?(record: CKRecord)
    var cloudKitRecordID: CKRecordID? { get set }
    var recordType: String { get }
}

extension CLoudKitSyncable {
    var isSynced: Bool {
        return cloudKitRecordID != nil
    }
    var cloudKitReference: CKReference? {
        guard let cloudKitRecordID = cloudKitRecordID else { return nil }
        return CKReference(recordID: cloudKitRecordID, action: .none)
    }
}
