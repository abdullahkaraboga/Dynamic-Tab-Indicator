//
//  Home.swift
//  DynamicTabIndicator
//
//  Created by Abdullah Karaboğa on 9.02.2023.
//


import SwiftUI

struct Home: View {
    @State private var currentTab: Tab = tabs_[0]
    @State private var tabs: [Tab] = tabs_
    @State private var contentOffset: CGFloat = 0
    @State private var indicatorWidth: CGFloat = 0
    @State private var indicatorPosition: CGFloat = 0
    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(tabs) { tab in
                GeometryReader {
                    let size = $0.size

                    Image(tab.tltle)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                    .clipped()
                    .ignoresSafeArea()
                    .offSetX { rect in
                    if currentTab.tltle == tab.tltle {
                        contentOffset = rect.minX - (rect.width * CGFloat(index(of: tab)))
                    }

                    updateTabFrame(rect.width)

                }.tag(tab)
            }

        }.tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            .overlay(alignment: .top, content: {
            TabsView()
        })
            .preferredColorScheme(.dark)

    }

    func updateTabFrame(_ tabViewWidth: CGFloat) {
        let inputRange = tabs.indices.compactMap { index -> CGFloat? in
            return CGFloat(index) * tabViewWidth
        }

        let outputRangeForWidth = tabs.compactMap { tab -> CGFloat? in
            return tab.width
        }

        let outputRangeForPosition = tabs.compactMap { tab -> CGFloat? in
            return tab.minX
        }

        let widthInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
        let positionInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)


        indicatorWidth = widthInterpolation.calculate(for: -contentOffset)
        indicatorPosition = positionInterpolation.calculate(for: -contentOffset)

    }

    func index(of tab: Tab) -> Int {
        return tabs.firstIndex(of: tab) ?? 0
    }

    @ViewBuilder
    func TabsView() -> some View {
        HStack(spacing: 0) {
            ForEach($tabs) { $tab in
                Text(tab.tltle)
                    .fontWeight(.semibold)
                    .offSetX { rect in
                    tab.minX = rect.minX
                    tab.width = rect.width
                }

                if tabs.last != tab {
                    Spacer(minLength: 0)
                }
            }
        }
            .padding([.top, .horizontal], 15)
            .overlay(alignment: .bottomLeading, content: {
            Rectangle()
                .frame(width: indicatorWidth, height: 4)
                .offset(x: indicatorPosition, y: 10)
        })
            .foregroundColor(.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

