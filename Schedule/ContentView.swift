//
//  ContentView.swift
//  Schedule
//
//  Created by admin on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            GroupPickerScreen()
        }
//        NavigationView {
//            NavigationLink(destination: Text("lalala")) {
//                Text("lalala")
//            }
//            .onTapGesture {
//                print("lalala")
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
