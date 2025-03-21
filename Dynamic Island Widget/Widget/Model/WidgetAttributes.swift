//
//  WidgetAttributes.swift
//  Signal Up
//
//  Created by Aren Musayelyan on 26.02.25.
//

import ActivityKit
import Foundation

struct WidgetAttributes: ActivityAttributes, Identifiable, Equatable {
    public typealias Content = ContentState
    
    // MARK: - ContentState
    public struct ContentState: Codable, Hashable {
        var tokenName: String
    }
    
    // MARK: - Properties
    var id = UUID()
    var price: Double
    var percentage: Double
    var name: String
    var isSignalUp: Bool
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
