//
//  DateView\.swift
//  Schedule
//
//  Created by admin on 15.02.2023.
//

import SwiftUI

struct DateView: View {
    
    var dayOfWeek: String
    var dayOfMonth: String
    var isPressed: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12).fill(isPressed ? Color.selectedDayColor : Color.white)
                .frame(width: 45, height: 65)
            VStack (spacing: 4) {
                Text(dayOfWeek)
                    .foregroundColor(isPressed ? Color.white : Color.softGray)
                    .font(.custom("Poppins-Medium", size: 14))
                Text(String(dayOfMonth))
                    .foregroundColor(isPressed ? Color.white : Color.dayOfMonthColor)
                    .font(.custom("Poppins-Semibold", size: 17))
            }
            .padding([.leading, .trailing], 12)
            .padding([.top, .bottom], 10)
        }
        .frame(width: 50, height: 65)
    }
}

struct DateView__Previews: PreviewProvider {
    static var previews: some View {
        DateView(dayOfWeek: "M", dayOfMonth: "21", isPressed: true)
    }
}
