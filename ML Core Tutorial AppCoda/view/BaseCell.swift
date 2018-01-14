//
//  BaseCell.swift
//  ML Core Tutorial AppCoda
//
//  Created by Arifin Firdaus on 1/15/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var dataSource: String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        guard let title = dataSource else { return }
        
        titleLabel.text = title
        
        if title == "Face detection" {
            titleLabel.textColor = UIColor.black
        } else {
            titleLabel.textColor = UIColor.lightGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
