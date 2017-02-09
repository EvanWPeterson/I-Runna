//
//  RunGroupListViewController.swift
//  I Runna
//
//  Created by Evan Peterson on 1/25/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class RunGroupListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var searchController: UISearchController?
    
    private var resultsController: RunGroupInfoViewController?
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.frame = view.bounds
        
        gradientLayer.startPoint = CGPoint(x: 174, y: 0)
        gradientLayer.endPoint = CGPoint(x: 188, y: 639)
        
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundView
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        self.tableView?.addSubview(refreshControl)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(postsWereUpdated), name: RunGroupController.postsChangedNotification, object: nil)
        
    }
    
    let gradientLayer = CAGradientLayer()
    
    let color1 = UIColor(red: 76/255, green: 75/255, blue: 92/255, alpha: 1.0)
    let color2 = UIColor(red: 112/255, green: 111/255, blue: 126/255, alpha: 0.75)
    
    func postsWereUpdated() {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func refresh(sender: Any) {
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.darkGray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RunGroupController.sharedController.runGroup.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rgPostCell", for: indexPath) as? RunGroupTableViewCell  else { return UITableViewCell() }
        let rGroup = RunGroupController.sharedController.runGroup[indexPath.row]
        cell.updateWithPost(runGroup: rGroup)
        return cell
    }
    
//     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let runGroup = RunGroupController.sharedController.runGroup(at: indexPath)
//            RunGroupController.sharedController.remove(runGroup: runGroup)
//            
//        }
//    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text {
            let filteredPost = RunGroupController.sharedController.runGroup.filter { $0.matchesSearchTerm(searchTerm: searchTerm) }
            resultsController?.resultsArray = filteredPost
            resultsController?.reloadInputViews()
        }
    }
    

    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRunInfo" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let runGroup = RunGroupController.sharedController.runGroup[indexPath.row]
                if let runGroupInfoViewController = segue.destination as? RunGroupInfoViewController {
                    runGroupInfoViewController.runGroup = runGroup
                    
                }
            }
        }
    }
}


