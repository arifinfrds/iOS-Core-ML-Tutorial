//
//  RoundedButton.swift
//  ML Core Tutorial AppCoda
//
//  Created by Arifin Firdaus on 10/7/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    var fontSize = CGFloat(15.0)
    var buttonHeight = CGFloat(50.0)
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: buttonHeight)
        self.backgroundColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        self.titleLabel?.textColor = UIColor.white
    }
    
}
