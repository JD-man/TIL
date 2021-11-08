//
//  UIFont+Extension.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import Foundation
import UIKit

extension UIFont {
    /*
     나눔스퀘어라운드
     NanumSquareRoundOTF
     =====> NanumSquareRoundOTFR
     =====> NanumSquareRoundOTFL
     =====> NanumSquareRoundOTFB
     =====> NanumSquareRoundOTFEB
     */
    
    class func nanumSquareRoundRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "NanumSquareRoundOTFR", size: size)!
    }
    class func nanumSquareRoundLight(size: CGFloat) -> UIFont {
        return UIFont(name: "NanumSquareRoundOTFL", size: size)!
    }
    class func nanumSquareRoundBold(size: CGFloat) -> UIFont {
        return UIFont(name: "NanumSquareRoundOTFB", size: size)!
    }
    class func nanumSquareRoundExtraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "NanumSquareRoundOTFEB", size: size)!
    }
}
