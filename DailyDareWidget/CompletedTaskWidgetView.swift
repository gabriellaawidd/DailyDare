//
//  CompletedTaskWidgetView.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 08/09/26.
//

import SwiftUI
import WidgetKit

struct CompletedTaskWidgetView: View {
    var body: some View {
        HStack(spacing: 8) {
            Image("completeMascot")
                .resizable()
                .frame(width: 80, height: 80)
            
            Text("You showed up for yourself today! That's what responsibility looks like")
                .font(.subheadline)
                .bold()
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .containerBackground(.black, for: .widget)
    }
}

struct CompletedTaskWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTaskWidgetView()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
