//
//  ListRow.swift
//  Schedule
//
//  Created by admin on 23.02.2023.
//

import SwiftUI

struct ListRow: View {
    
    var text: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .bottom], 12)
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(.dayOfMonthColor)
                Spacer()
                Image(systemName: "chevron.forward")
            }
//                                .frame(height: 30)
            .padding([.leading, .trailing], 20)
            Rectangle().fill(Color.softGray).frame(height: 1)
                .padding(.leading, 20)

        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(text: "Some group")
    }
}
