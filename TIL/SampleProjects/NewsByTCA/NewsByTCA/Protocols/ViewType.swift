//
//  ViewType.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import Foundation
import ComposableArchitecture

protocol TCAViewType {
    associatedtype State
    associatedtype Action
    
    var store: Store<State, Action> { get }
}
