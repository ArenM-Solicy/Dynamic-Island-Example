//
//  SignalUpWidgetViewModel.swift
//  Signal Up
//
//  Created by Aren Musayelyan on 10.03.25.
//

import Foundation
import SwiftUI

class WidgetViewModel: ObservableObject {
    @Published var attributes: WidgetAttributes
    
    init(attributes: WidgetAttributes) {
        self.attributes = attributes
    }
    
    // MARK: - Formatting Functions
    func formattedPrice() -> String {
        return "$\(String(format: "%.2f", attributes.price)) "
    }
    
    func formattedPercentage() -> String {
        return "\(attributes.isSignalUp ? "+" : "-") \(String(format: "%.2f", attributes.percentage))%"
    }
    
    func signalColor() -> Color {
        return attributes.isSignalUp ? .customGreen : .customRed
    }
    
    // MARK: - URL Generation
    func generateURL() -> URL? {
        var urlComponents = URLComponents(string: "LiveActivities://")!
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: attributes.id.uuidString),
            URLQueryItem(name: "price", value: "\(attributes.price)"),
            URLQueryItem(name: "percentage", value: "\(attributes.percentage)"),
            URLQueryItem(name: "name", value: attributes.name),
            URLQueryItem(name: "isSignalUp", value: "\(attributes.isSignalUp)")
        ]
        return urlComponents.url
    }
}
