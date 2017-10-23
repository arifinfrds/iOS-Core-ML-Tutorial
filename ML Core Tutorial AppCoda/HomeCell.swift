//
//  RoundedCell.swift
//  ML Core Tutorial AppCoda
//
//  Created by Arifin Firdaus on 10/6/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var imageViewHeader: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // setupShadow()
//        self.layer.cornerRadius = 10
//        self.layer.masksToBounds = true
//        self.layer.borderWidth = 0.2
//        self.layer.borderColor = UIColor.gray.cgColor
    
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
