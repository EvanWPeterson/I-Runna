//
//  RunGroupTableViewCell.swift
//  I Runna
//
//  Created by Evan Peterson on 1/26/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class RunGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var runGroupLocationLabel: UILabel!
    @IBOutlet weak var runGroupNameLabel: UILabel!
    @IBOutlet weak var runPaceLabel: UILabel!
    @IBOutlet weak var runGroupLogoImageView: UIImageView!

    
    override func awakeFromNib() {
        runGroupLogoImageView.layer.cornerRadius = runGroupLogoImageView.frame.size.height/2
        runGroupLogoImageView.layer.masksToBounds = true
        runGroupLogoImageView.layer.borderColor = UIColor.black.cgColor
        runGroupLogoImageView.layer.borderWidth = 2
    }
    
    func updateWithPost(runGroup: RunGroup) {
        guard let runLogo = runGroup.runLogo else {
            return
        }
        runPaceLabel?.text = "\(runGroup.runPace)MIN/MILE"
        runGroupNameLabel?.text = runGroup.runGroupName
        runGroupLocationLabel?.text = runGroup.runGroupLocation
        runGroupLogoImageView?.image = UIImage(data: runLogo)
    
    }

}
