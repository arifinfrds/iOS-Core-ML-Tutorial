//
//  HomeViewController.swift
//  ML Core Tutorial AppCoda
//
//  Created by Arifin Firdaus on 10/5/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var models = Home.getDataSource()
    
    @IBOutlet var tableViewHome: UITableView!
    
    let tableViewHeight = CGFloat(266.0)
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHome.dataSource = self
        tableViewHome.delegate = self
        
        setupNavBar()
        
        check3DTouchSupport()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // setup search controller
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }
    
    func check3DTouchSupport() {
        guard traitCollection.forceTouchCapability == .available else { return }
        registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: view)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableViewHome.indexPathForSelectedRow {
            let row = indexPath.row
            if segue.identifier == "app_coda_segue" {
                let appCodaVC = segue.destination as! AppCodaViewController
                appCodaVC.navigationItem.title = models[row].title
            }
            
            if segue.identifier == "segue_vision_view_controller" {
                let visionVC = segue.destination as! VisionViewController
                visionVC.navigationItem.title = models[row].title
            }
        }
        
    }
    
    // TODO: fix later, UI later
    func setupHomeCell(cell: HomeCell, indexPath: IndexPath) {
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.borderColor = UIColor.gray.cgColor
    }
    
    
}


// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewHome.dequeueReusableCell(withIdentifier: "home_cell", for: indexPath) as! HomeCell
        cell.dataSource = models[indexPath.row]
        return cell
    }
}


// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if (storyboard?.instantiateViewController(withIdentifier: "app_coda_view_controller") as?
                AppCodaViewController) != nil {
                performSegue(withIdentifier: "app_coda_segue", sender: self)
            }
        }
        
        if indexPath.row == 1 {
            if (storyboard?.instantiateViewController(withIdentifier: "vision_view_controller") as?
                VisionViewController) != nil {
                performSegue(withIdentifier: "segue_vision_view_controller", sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


// MARK: - UIViewControllerPreviewingDelegate
extension HomeViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableViewHome?.indexPathForRow(at: location) else { return nil }
        guard let cell = tableViewHome?.cellForRow(at: indexPath) else { return nil }
        previewingContext.sourceRect = cell.frame
        
        if indexPath.row == 0 {
            guard let appCodaViewController = storyboard?.instantiateViewController(withIdentifier: "app_coda_view_controller") as? AppCodaViewController else { return nil }
            
            let model = models[indexPath.row]
            appCodaViewController.navigationItem.title = model.title
            appCodaViewController.preferredContentSize = CGSize(width: 0, height: 500)
            return appCodaViewController
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    
}




