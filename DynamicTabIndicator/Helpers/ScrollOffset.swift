//
//  ScrollOffset.swift
//  DynamicTabIndicator
//
//  Created by Abdullah Karaboğa on 9.02.2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func offSetX(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
            GeometryReader { proxy in

                let rect = proxy.frame(in: .global)

                Color.clear
                    .preference(key: OffsetKey.self, value: rect)
                    .onPreferenceChange(OffsetKey.self,perform: completion)
            }
        }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
