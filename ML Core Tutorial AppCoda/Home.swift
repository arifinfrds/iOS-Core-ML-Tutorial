//
//  Home.swift
//  ML Core Tutorial AppCoda
//
//  Created by Arifin Firdaus on 10/6/17.
//  Copyright © 2017 Arifin Firdaus. All rights reserved.
//

import UIKit

class Home {
    
    private let _title: String!
    private let _detail: String!
    private let _thumbnail: UIImage!
    
    init(title: String, detail: String, thumbnail: UIImage) {
        _title = title
        _detail = detail
        _thumbnail = thumbnail
    }
    
    var title: String {
        return _title
    }
    
    var detail: String {
        return _detail
    }
    
    var thumbnail: UIImage {
        return _thumbnail
    }
    
}
