//
//  RunMapDetailViewController.swift
//  I Runna
//
//  Created by Evan Peterson on 2/6/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit
import MapKit

class RunMapDetailViewController: UIViewController {

    @IBOutlet weak var runDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMapDetail()

    }

    var mapDetail: RunInfo?
    
    func updateMapDetail() {
        runDetailLabel.text = mapDetail?.detailsOfRun
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
