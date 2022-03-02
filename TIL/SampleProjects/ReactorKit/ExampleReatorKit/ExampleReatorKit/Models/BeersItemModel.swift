//
//  BeersItemModel.swift
//  ExampleReatorKit
//
//  Created by JD_MacMini on 2022/03/02.
//

import Foundation

// name
// image
// tagline
// description

struct BeersItemModel {
    let name: String
    let imageURL: URL?
    let tagline: String
    let description: String
    
    init(name: String, imageURL: String, tagline: String, description: String) {
        self.name = name
        self.imageURL = URL(string: imageURL) ?? nil
        self.tagline = tagline
        self.description = description
    }
}
