//
//  Home.swift
//  Dynamic Island
//
//  Created by Aren Musayelyan on 20.03.25.
//

import SwiftUI
import ActivityKit

// MARK: - Main View
struct Home: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var showTokenDetails = false
    @Namespace private var animationNamespace
    
    // MARK: - Initializer
    init(viewModel: HomeViewModel = HomeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // MARK: - Token Details Section
                if showTokenDetails, let activity = viewModel.currentActivity {
                    TokenDetailsView(activity: activity)
                        .matchedGeometryEffect(id: "tokenDetails", in: animationNamespace)
                        .transition(.scale.combined(with: .opacity))
                }
                
                // MARK: - Action Buttons
                ActionButtons(viewModel: viewModel)
            }
            .padding(.bottom, 60)
            .padding()
            .onChange(of: viewModel.activityID) { _ in
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
                    showTokenDetails = (viewModel.currentActivity != nil)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center).opacity(0.6))
    }
}

// MARK: - Subviews
private extension Home {
    
    // MARK: - Token Details View
    @ViewBuilder
    func TokenDetailsView(activity: Activity<WidgetAttributes>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            TokenDetailRow(tokenName: activity.attributes.name, imageString: "solana-logo")
            PriceDetailsRow(price: activity.attributes.price, percentage: activity.attributes.percentage)
        }
        .padding()
        .background(AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center).opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center),
                    lineWidth: 2
                )
        )
    }
    
    // MARK: - Token Detail Row
    func TokenDetailRow(tokenName: String, imageString: String) -> some View {
        HStack {
            Image(imageString)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(tokenName)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text("Token Price")
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
    
    // MARK: - Price Details Row
    func PriceDetailsRow(price: Double, percentage: Double) -> some View {
        HStack(spacing: 4) {
            PriceText(value: price)
            Spacer()
            Image(systemName: "arrowshape.right.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
            Spacer()
            PriceText(value: price + (price * percentage / 100))
            PercentageText(value: percentage)
        }
    }
    
    // MARK: - Price Text
    func PriceText(value: Double) -> some View {
        Text("$\(String(format: "%.2f", value))")
            .font(.title2)
            .foregroundColor(.primary)
    }
    
    // MARK: - Percentage Text
    func PercentageText(value: Double) -> some View {
        Text("\(String(format: "%.2f", value))%")
            .font(.caption)
            .bold()
            .padding(6)
            .background(Color.black)
            .clipShape(Capsule())
            .foregroundColor(.white)
    }
    
    // MARK: - Action Buttons
    func ActionButtons(viewModel: HomeViewModel) -> some View {
        VStack(spacing: 10) {
            Button(action: { viewModel.createActivity() }) {
                Label("Generate Signal", systemImage: "bolt.fill")
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button(action: { viewModel.endActivity() }) {
                Label("End Signal", systemImage: "stop.circle.fill")
            }
            .buttonStyle(SecondaryButtonStyle())
        }
    }
}

// MARK: - Button Styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: UIScreen.main.bounds.width / 2)
            .padding()
            .background(Color.blue.gradient)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: UIScreen.main.bounds.width / 2)
            .padding()
            .background(Color.red.gradient)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

// MARK: - Preview
#Preview {
    Home()
}
