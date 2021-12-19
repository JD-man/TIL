//
//  FontFinder.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import Foundation
import UIKit

// Using in HomeViewContoller viewDidLoad to find font name
struct FontFinder {
    static func findFont() {
        for family in UIFont.familyNames {
            print(family)
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("=====> \(name)")
            }
        }
    }
}
