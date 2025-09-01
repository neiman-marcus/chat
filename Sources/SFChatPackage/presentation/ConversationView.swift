//
//  ConversationView.swift
//  SFChatPackage
//

import SwiftUI
import UIKit
import Foundation
import SMIClientUI
import SwiftUICore

// MARK: - Custom Navigation Bar Modifier
struct CustomNavigationBar: ViewModifier {
    let title: String
    let trailingAction: () -> Void
    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Left: Custom back button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    }
                }
                
                // Center: Title
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                // Right: Star button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: trailingAction) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                }
            }
    }
}

extension View {
    func customNavigationBar(title: String, trailingAction: @escaping () -> Void) -> some View {
        self.modifier(CustomNavigationBar(title: title, trailingAction: trailingAction))
    }
}

// MARK: - Conversation View
@MainActor
public struct ConversationView: View {
    public init() { 
        // UINavigationBar appearance setup
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "SMI.navigationBackground") ?? UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "SMI.navigationText") ?? .white]
        app
