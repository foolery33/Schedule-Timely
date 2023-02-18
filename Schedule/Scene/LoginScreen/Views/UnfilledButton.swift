//
//  UnfilledButton.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct UnfilledButton: View {
    
    var text: String
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.softGray, lineWidth: 1)
                    .frame(width: UIScreen.main.bounds.size.width / 2 - 20 - 10, height: 40)
                Text(text)
                    .foregroundColor(.dayOfMonthColor)
                    .font(.custom("Poppins-Medium", size: 14))
            }
        }
    }
}

struct UnfilledButton_Previews: PreviewProvider {
    static var previews: some View {
        UnfilledButton(text: "Student")
    }
}
