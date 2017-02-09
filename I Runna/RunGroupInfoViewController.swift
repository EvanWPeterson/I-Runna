//
//  RunGroupInfoViewController.swift
//  I Runna
//
//  Created by Evan Peterson on 2/2/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class RunGroupInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sourceTableViewController: UITableViewController?
    var resultsArray: [SearchableRecord] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var runPaceLabel: UILabel!
    @IBOutlet weak var runGroupLocationLabel: UILabel!
    @IBOutlet weak var runLogoImageView: UIImageView!
    
    
    var runGroup: RunGroup?
    var runInfo: RunInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWithRunGroupPost()
        
        runLogoImageView.layer.cornerRadius = runLogoImageView.frame.size.height/2
        runLogoImageView.layer.masksToBounds = true
        runLogoImageView.layer.borderColor = UIColor.black.cgColor
        runLogoImageView.layer.borderWidth = 2
        
        NotificationCenter.default.addObserver(self, selector: #selector(runsWereUpdated), name: RunGroupController.runPostsChangedNotification, object: runInfo)
    }
    
    
    
    func runsWereUpdated() {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    func updateWithRunGroupPost() {
         guard let runGroup = runGroup,
            let runLogo = runGroup.runLogo else { return }
        
        runPaceLabel.text = "\(runGroup.runPace)MIN/MILE"
        runGroupLocationLabel.text = runGroup.runGroupLocation
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
        if segue.identifier == "toMapDetail" {
           if let indexPath = tableView.indexPathForSelectedRow {
                    let mapDetail = RunInfoController.sharedController.runInfo[indexPath.row]
            if let RunMapDetailViewController = segue.destination as? RunMapDetailViewController  {
                    RunMapDetailViewController.mapDetail = mapDetail
                }
            }
            
        }
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        guard let runGroup = runGroup else { return }
        let activityController = UIActivityViewController(activityItems: [runGroup.photo], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
}



