//
//  LoadingDataProtocol.swift
//  Schedule
//
//  Created by admin on 05.03.2023.
//

import Foundation
import SwiftUI

class LoadingDataClass: ObservableObject {
    @Published var error: AppError?
    @Published var showContent: Bool = false
    @Published var showProgressView: Bool = false
}
