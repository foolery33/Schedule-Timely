//
//  TextFieldView.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct TextFieldView: View {
    
    var header: String
    @State var text: String
    var placeholderText: String
    var isSecuredField: Bool
    @State var showPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(header)
                .font(.custom("Poppins-Medium", size: 13))
                .foregroundColor(.dayOfMonthColor)
            ZStack(alignment: .leading) {
                if(text.isEmpty) {
                    Text(placeholderText)
                        .padding(.leading, 16)
                        .foregroundColor(.softGray)
                        .font(.custom("Poppins-Regular", size: 14))
                    
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 4).stroke(Color.softGray, lineWidth: 1).padding([.leading, .trailing], 0.3).frame(height: 45)
                    HStack {
                        if(showPassword) {
                            SecureField("", text: $text)
                                .foregroundColor(.dayOfMonthColor)
                                .font(.custom("Poppins-Regular", size: 14))
                                .padding(.leading, 16)
                                .frame(height: 45)
                        }
                        else {
                            TextField("", text: $text)
                                .foregroundColor(.dayOfMonthColor)
                                .font(.custom("Poppins-Regular", size: 14))
                                .padding(.leading, 16)
                                .frame(height: 45)
                        }
                        if(isSecuredField) {
                            Spacer()
                            if(showPassword) {
                                Image(systemName: "eye.slash")
                                    .padding(.bottom, 0.9)
                                    .foregroundColor(.dayOfMonthColor)
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.1)) {
                                            showPassword.toggle()
                                        }
                                    }
                                    .imageScale(.small)
                            }
                            else {
                                Image(systemName: "eye")
                                    .foregroundColor(.dayOfMonthColor)
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.1)) {
                                            showPassword.toggle()
                                        }
                                    }
                                    .imageScale(.small)
                            }
                            Spacer().frame(width: 16)
                        }
                    }
                }
            }
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(header: "Email Address", text: "", placeholderText: "Enter something", isSecuredField: true)
    }
}
