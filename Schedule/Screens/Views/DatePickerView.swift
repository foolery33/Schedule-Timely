//
//  DatePickerView.swift
//  Schedule
//
//  Created by admin on 25.02.2023.
//

import SwiftUI

struct DatePickerView: View {
    
    @Binding var selectedDate: Date
    var action: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Image(systemName: "chevron.backward")
                    .padding(.leading, 10)
                    .font(.system(size: 16, weight: .medium))
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                Text("Pick any date")
                    .frame(maxWidth: .infinity)
                    .font(.custom("Poppins-Bold", size: 17))
            }
            .foregroundColor(.dayOfMonthColor)
            DatePicker(selection: $selectedDate, displayedComponents: [.date], label: {
                Text("Select a date")
            })
            .datePickerStyle(.wheel)
            .labelsHidden()
            FilledButton(text: "Choose") {
                action()
                dismiss()
            }
            .padding([.leading, .trailing], 20)
        }
        .frame(height: 350)
    }
}

struct DatePickerView_Previews: PreviewProvider {
    @State static var selectedDate: Date = Date()
    static var previews: some View {
        DatePickerView(selectedDate: $selectedDate, action: {})
    }
}
