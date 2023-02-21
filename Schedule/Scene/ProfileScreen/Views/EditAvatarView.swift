//
//  EditAvatarView.swift
//  Schedule
//
//  Created by admin on 20.02.2023.
//

import SwiftUI

struct EditAvatarView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 46, height: 46)
            Circle()
                .fill(Color.softWhite2)
                .frame(width: 35, height: 35)
            Image(systemName: "square.and.pencil")
                .foregroundColor(.dayOfMonthColor)
        }
    }
}

struct EditAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        EditAvatarView()
            .preferredColorScheme(.dark)
    }
}
