//
//  NoHighlightsButtonStyle.swift
//  Schedule
//
//  Created by admin on 27.02.2023.
//

import SwiftUI

struct NoHighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .opacity(1)
    }
}
