//
//  FilledButton.swift
//  Schedule
//
//  Created by admin on 18.02.2023.
//

import SwiftUI

struct FilledButton: View {
    
    var text: String
    var action: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.custom("Poppins-Regular", size: 13))
            .padding([.top, .bottom], 11)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 6).fill(Color.darkGreenColor)
            .frame(height: 40))
            .onTapGesture {
                action()
            }
        
    }
}

//struct FilledButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FilledButton(text: "Login")
//    }
//}
