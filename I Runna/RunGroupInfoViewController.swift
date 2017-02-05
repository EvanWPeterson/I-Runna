//
//  RunGroupInfoViewController.swift
//  I Runna
//
//  Created by Evan Peterson on 2/2/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class RunGroupInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBOutlet weak var runPaceLabel: UILabel!
    @IBOutlet weak var runGroupLocationLabel: UILabel!
    @IBOutlet weak var runLogoImageView: UIImageView!
    
    
    var runGroup: RunGroup?
    var runInfo: RunInfo?
    weak var delegate: RunInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWithRunGroupPost()
    
        
    }
    
    func updateWithRunGroupPost() {
        guard let runLogo = runGroup?.runLogo else { return }
        
        runPaceLabel.text = runGroup?.runPace
        runGroupLocationLabel.text = runGroup?.runGroupLocation
        runLogoImageView.image = UIImage(data: runLogo)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RunInfoController.sharedController.runInfo.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "runInfoCell", for: indexPath) as?
            RunInfoTableViewCell else { return UITableViewCell() }
        let rInfo = RunInfoController.sharedController.runInfo[indexPath.row]
        cell.updateWithRunPost(runInfo: rInfo)
        
        return cell
        
    }
  


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        guard let runGroup = runGroup else { return }
        let activityController = UIActivityViewController(activityItems: [runGroup.photo], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
}

protocol RunInfoDelegate: class {
    func runInfo(_: RunInfo)
}

