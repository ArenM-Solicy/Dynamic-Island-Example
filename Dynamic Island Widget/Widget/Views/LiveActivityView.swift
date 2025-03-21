//
//  SignalUpLiveActivityView.swift
//  Dynamic Island
//
//  Created by Aren Musayelyan on 20.03.25.
//

import SwiftUI
import WidgetKit

struct LiveActivityView: View {
    @StateObject private var viewModel: LiveActivityViewModel
    
    init(context: WidgetAttributes = LiveActivityViewModel.defaultContext()) {
        _viewModel = StateObject(wrappedValue: LiveActivityViewModel(context: context))
    }
    
    var body: some View {
        VStack {
            headerView()
            centerContentView()
            actionButtons()
        }
        .padding()
        .background(Color.black)
    }
    
    // MARK: - Header View
    private func headerView() -> some View {
        HStack {
            HStack(spacing: 6) {
                Image(systemName: "apple.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.white)
                
                Text("Signal Up")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            HStack(spacing: 6) {
                Text("Open App")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8, height: 8)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 10)
    }
    
    // MARK: - Center Content View
    private func centerContentView() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                Image("solana-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Text(viewModel.context.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            HStack(spacing: 4) {
                Text("$\(String(format: "%.2f", viewModel.context.price)) ")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                Text("+\(String(format: "%.2f", viewModel.context.percentage))%")
                    .font(.system(size: 12, weight: .bold))
                    .padding(6)
                    .background(viewModel.context.isSignalUp ? Color.customGreen : Color.customRed)
                    .clipShape(Capsule())
                    .foregroundColor(.black)
            }
        }
    }
    
    // MARK: - Action Buttons
    private func actionButtons() -> some View {
        HStack(spacing: 10) {
            actionButton(title: "Signal Up", color: .customGreen, isEnabled: viewModel.context.isSignalUp)
            actionButton(title: "Signal Down", color: .customRed, isEnabled: !viewModel.context.isSignalUp)
        }
    }
    
    private func actionButton(title: String, color: Color, isEnabled: Bool) -> some View {
        Group {
            if isEnabled, let url = viewModel.generateURL() {
                Link(destination: url) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(color)
                        .clipShape(Capsule())
                        .foregroundColor(.black.opacity(0.8))
                }
            } else {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Capsule())
                    .foregroundColor(color)
            }
        }
    }
}

#Preview {
    LiveActivityView(context: WidgetAttributes(id: UUID(), price: 100, percentage: 10, name: "Sol", isSignalUp: true))
}
