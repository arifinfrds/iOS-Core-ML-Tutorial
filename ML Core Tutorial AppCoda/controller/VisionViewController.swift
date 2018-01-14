//
//  VisionViewController.swift
//  ML Core Tutorial AppCoda
//
//  Created by Arifin Firdaus on 1/15/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import UIKit

class VisionViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var visionTableView: UITableView!
    
    let visionAPIList = [
        "Face tracking",
        "Face detection",
        "landmarks",
        "text detection",
        "rectangle detection",
        "barcode detection",
        "object tracking",
        "image registration"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visionTableView.dataSource = self
        visionTableView.delegate = self
        
        setupCell()
        
    }
    
    private func setupCell() {
        let baseCellNib = UINib(nibName: "BaseCell", bundle: nil)
        visionTableView.register(baseCellNib, forCellReuseIdentifier: "base_cell")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

// MARK: - UITableViewDataSource
extension VisionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visionAPIList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "base_cell", for: indexPath) as! BaseCell
        cell.dataSource = visionAPIList[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension VisionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}



