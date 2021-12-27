//
//  Observable.swift
//  SeSAC_Week14
//
//  Created by JD_MacMini on 2021/12/27.
//

import Foundation

class Observable<T> {
    private var listner: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listner = closure
    }
}


