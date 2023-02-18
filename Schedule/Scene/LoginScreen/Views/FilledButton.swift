//
//  FilledButton.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct FilledButton: View {
    
    var text: String
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                RoundedRectangle(cornerRadius: 6).fill(Color.darkGreenColor).frame(height: 40)
                Text(text)
                    .foregroundColor(.white)
                    .font(.custom("Poppins-Regular", size: 13))
                    .padding([.top, .bottom], 11)
            }
        }
    }
}

struct FilledButton_Previews: PreviewProvider {
    static var previews: some View {
        FilledButton(text: "Login")
    }
}
