//
//  Tab.swift
//  DynamicTabIndicator
//
//  Created by Abdullah Karaboğa on 9.02.2023.
//

import SwiftUI

struct Tab: Identifiable, Hashable{
    var id : UUID = .init()
    var tltle : String
    var width: CGFloat = 0
    var minX: CGFloat = 0
    
}

var tabs_: [Tab] = [
    .init(tltle: "Tiny"),
    .init(tltle: "Medium"),
    .init(tltle: "Large"),
    .init(tltle: "Extra Large"),
]
