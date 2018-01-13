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
    
    static func getDataSource() -> [Home] {
        return [
            Home(
                title: "Core ML",
                detail: "Inceptionv3.mlmodel by App Coda",
                thumbnail: #imageLiteral(resourceName: "core_ml_1")
            ),
            Home(
                title: "Vision",
                detail: "You can easily build computer vision machine learning features into your app. Supported features include face tracking, face detection, landmarks, text detection, rectangle detection, barcode detection, object tracking, and image registration.",
                thumbnail: #imageLiteral(resourceName: "core_ml_3")
            ),
            Home(
                title: "Natural Language Processing",
                detail: "The natural language processing APIs in Foundation use machine learning to deeply understand text using features such as language identification, tokenization, lemmatization, part of speech, and named entity recognition.",
                thumbnail: #imageLiteral(resourceName: "core_ml_3")
            )
        ]
    }
    
}
