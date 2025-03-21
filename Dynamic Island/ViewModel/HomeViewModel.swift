//
//  HomeViewModel.swift
//  Dynamic Island
//
//  Created by Aren Musayelyan on 20.03.25.
//

import Foundation
import ActivityKit
import SwiftUI

// MARK: - HomeViewModel
class HomeViewModel: ObservableObject {
    @Published private(set) var currentActivity: Activity<WidgetAttributes>?
    @Published var activityID: UUID?
    
    // MARK: - Create Activity
    func createActivity() {
        let signal = generateRandomSignal()
        let attributes = WidgetAttributes(
            price: signal.price,
            percentage: signal.percentage,
            name: signal.name,
            isSignalUp: signal.isSignalUp
        )
        let content = WidgetAttributes.Content(tokenName: signal.name)
        
        do {
            // Request a new activity
            let activity = try Activity<WidgetAttributes>.request(
                attributes: attributes,
                content: ActivityContent(state: content, staleDate: nil),
                pushType: .token
            )
            
            // Update state after activity creation
            DispatchQueue.main.async {
                self.currentActivity = activity
                self.activityID = UUID()
            }
        } catch {
            // Handle any errors that may occur
            print("Error requesting activity: \(error.localizedDescription)")
        }
    }
    
    // MARK: - End Activity
    func endActivity() {
        guard let activity = currentActivity else { return }
        
        let endContent = ActivityContent(state: WidgetAttributes.Content(tokenName: "Ended"), staleDate: Date())
        
        // MARK: - End activity asynchronously
        Task {
            await activity.end(endContent, dismissalPolicy: .immediate)
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.currentActivity = nil
                    self.activityID = UUID()
                }
            }
        }
    }
    
    // MARK: - Generate Random Signal
    func generateRandomSignal() -> Signal {
        let tokens = ["Solana", "Ethereum", "Bitcoin", "Ripple"]
        return Signal(
            name: tokens.randomElement() ?? "Solana",
            price: Double.random(in: 130...150),
            percentage: Double.random(in: 0...10),
            isSignalUp: Bool.random()
        )
    }
}
