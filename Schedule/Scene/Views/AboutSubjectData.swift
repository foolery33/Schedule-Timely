//
//  AboutSubjectData.swift
//  Schedule
//
//  Created by admin on 16.02.2023.
//

import SwiftUI

struct AboutSubjectData: View {
    
    var iconName: String
    var textInfo: String
    
    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: iconName).imageScale(.small)
                .frame(width: 15)
            Text(textInfo)
                .font(.custom("Poppins-Regular", size: 14))
        }
    }
}

struct AboutSubjectData_Previews: PreviewProvider {
    static var previews: some View {
        AboutSubjectData(iconName: "location", textInfo: "lalala")
    }
}
