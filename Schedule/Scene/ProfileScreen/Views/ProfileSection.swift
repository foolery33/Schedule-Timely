//
//  ProfileSeciton.swift
//  Schedule
//
//  Created by admin on 20.02.2023.
//

import SwiftUI

struct ProfileSection: View {
    
    let imageName: String
    let text: String
    let paddings: EdgeInsets
    
    var body: some View {
        HStack(alignment: .top, spacing: 13) {
            Image(systemName: imageName)
                .frame(width: 24)
            Text(text)
                .font(.custom("Poppins-Regular", size: 15))
            Spacer()
        }
        .padding(paddings)
    }
}

struct ProfileSeciton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSection(imageName: "newspaper", text: "Edit profile information", paddings: EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}
