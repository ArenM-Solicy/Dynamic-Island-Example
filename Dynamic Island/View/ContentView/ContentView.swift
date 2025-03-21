//
//  ContentView.swift
//  Dynamic Island
//
//  Created by Aren Musayelyan on 20.03.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("Dynamic Island")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
