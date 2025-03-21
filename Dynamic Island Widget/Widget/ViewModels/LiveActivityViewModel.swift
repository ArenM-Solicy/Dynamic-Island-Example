//
//  SignalUpLiveActivityViewModel.swift
//  Dynamic Island
//
//  Created by Aren Musayelyan on 20.03.25.
//

import Foundation

class LiveActivityViewModel: ObservableObject {
    @Published var context: WidgetAttributes
    
    init(context: WidgetAttributes = LiveActivityViewModel.defaultContext()) {
        self.context = context
    }
    
    // Generate URL with query parameters
    func generateURL() -> URL? {
        guard let url = URL(string: "LiveActivities://") else { return nil }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "id", value: context.id.uuidString),
            URLQueryItem(name: "price", value: "\(context.price)"),
            URLQueryItem(name: "percentage", value: "\(context.percentage)"),
            URLQueryItem(name: "name", value: context.name),
            URLQueryItem(name: "isSignalUp", value: "\(context.isSignalUp)")
        ]
        
        return urlComponents?.url
    }
    
    // Static method to return default context
    static func defaultContext() -> WidgetAttributes {
        return WidgetAttributes(
            id: UUID(),
            price: 100,
            percentage: 20,
            name: "Solana",
            isSignalUp: false
        )
    }
}
