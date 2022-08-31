//
//  StoreType.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import Foundation
import ComposableArchitecture

protocol ComponentType {
    associatedtype State: Equatable
    associatedtype Action: Equatable
    associatedtype Environment
    
    var reducer: Reducer<State, Action, Environment> { get }
}
