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
                .frame(width: 38, height: 56)
            VStack (spacing: 3) {
                Text(dayOfWeek)
                    .foregroundColor(isPressed ? Color.white : Color.softGray)
                    .font(.custom("Poppins-Medium", size: 13))
                Text(String(dayOfMonth))
                    .foregroundColor(isPressed ? Color.white : Color.dayOfMonthColor)
                    .font(.custom("Poppins-Semibold", size: 17))
            }
            .padding([.leading, .trailing], 12)
            .padding([.top, .bottom], 10)
            .fixedSize()
        }
        .frame(width: 42, height: 60)
    }
}

struct DateView__Previews: PreviewProvider {
    static var previews: some View {
        DateView(dayOfWeek: "M", dayOfMonth: "21", isPressed: true)
    }
}
