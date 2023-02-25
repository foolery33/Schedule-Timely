//
//  SearchingTextField.swift
//  Schedule
//
//  Created by admin on 19.02.2023.
//

import SwiftUI

struct SearchingTextField: View {
    
    @Binding var text: String
    var header: String
    var placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(header)
                .font(.custom("Poppins-Medium", size: 13))
                .foregroundColor(.dayOfMonthColor)
            ZStack(alignment: .leading) {
                if(text.isEmpty) {
                    Text(placeholderText)
                        .padding(.leading, 16)
                        .foregroundColor(.grayColor)
                        .font(.custom("Poppins-Medium", size: 14))
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 4).fill(Color.softGray.opacity(0.3)).padding([.leading, .trailing], 0.3).frame(height: 45)
                    TextField("", text: $text)
                        .foregroundColor(.dayOfMonthColor)
                        .font(.custom("Poppins-Medium", size: 14))
                        .padding(.leading, 16)
                        .frame(height: 45)
                }
            }
        }
    }
}

//struct SearchingTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchingTextField(text: "", header: "Find your group", placeholderText: "Group number")
//    }
//}
