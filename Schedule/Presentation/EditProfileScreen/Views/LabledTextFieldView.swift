//
//  LabledTextField.swift
//  Schedule
//
//  Created by admin on 22.02.2023.
//

import SwiftUI

struct LabledTextFieldView: View {
    
    @State var writtenText: String = ""
    var labelText: String
    var placeholderText: String
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.softGray, lineWidth: 1)
                .frame(height: 50)
            VStack(alignment: .leading, spacing: 0) {
                Text(labelText)
                    .foregroundColor(.grayColor)
                    .font(.custom("Poppins-Regular", size: 11))
                TextField(text: $writtenText) {
                    Text(placeholderText)
                        .foregroundColor(.softGray)
                        .font(.custom("Poppins-Regular", size: 14))
                }
                .foregroundColor(.dayOfMonthColor)
                .font(.custom("Poppins-Regular", size: 14))
                
            }
            .padding(.top, 5)
            .padding(.leading, 16)
        }
    }
}

struct LabledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabledTextFieldView(labelText: "Full name", placeholderText: "")
    }
}
