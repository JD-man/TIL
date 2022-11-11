//
//  ViewBuilderType.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import SwiftUI

protocol ViewBuilderType {
  associatedtype ViewType: View
  var view: ViewType { get }
}
