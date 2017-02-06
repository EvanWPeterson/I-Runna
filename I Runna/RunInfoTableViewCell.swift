//
//  RunInfoTableViewCell.swift
//  I Runna
//
//  Created by Evan Peterson on 2/2/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class RunInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var runLocationLabel: UILabel!
    @IBOutlet weak var runNameLabel: UILabel!
    @IBOutlet weak var runDateTimeLabel: UILabel!
    @IBOutlet weak var runLengthLabel: UILabel!
 
    
    func updateWithRunPost(runInfo: RunInfo) {
        runLocationLabel?.text = runInfo.runLocation
        runNameLabel?.text = runInfo.runName
        runDateTimeLabel?.text = "\(runInfo.runDateTime)"
        runLengthLabel?.text = "\(runInfo.runLength)"
        
    }

}


