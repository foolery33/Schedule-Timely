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
  
        HStack {
            Text(text)
                .foregroundColor(.dayOfMonthColor)
                .font(.custom("Poppins-Medium", size: 14))
                .frame(height: 40)
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 4)
            .stroke(Color.softGray, lineWidth: 1)
            .frame(height: 40))
    }
}

struct UnfilledButton_Previews: PreviewProvider {
    static var previews: some View {
        UnfilledButton(text: "Student")
    }
}
