//
//  NavigationColorModifier.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//

import SwiftUI

struct NavigationColorModifier: ViewModifier {
    var titleColor: UIColor
    var tintColor: Color

    init(titleColor: UIColor, tintColor: Color) {
        self.titleColor = titleColor
        self.tintColor = tintColor
 
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        
        appearance.configureWithTransparentBackground()
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
            .tint(tintColor)
    }
}

extension View {
    func dailyDareNavigationTheme() -> some View {
        self.modifier(NavigationColorModifier(titleColor: .systemYellow, tintColor: .yellow))
    }
}
