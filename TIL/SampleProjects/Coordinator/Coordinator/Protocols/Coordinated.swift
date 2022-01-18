//
//  Coordinated.swift
//  Coordinator
//
//  Created by JD_MacMini on 2022/01/18.
//

import Foundation

protocol Coordinated {
    associatedtype T: CoordinatorType
    var coordinator: T? { get set }
}
