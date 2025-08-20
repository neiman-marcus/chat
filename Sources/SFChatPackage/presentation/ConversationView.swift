//
//  ConversationView.swift
//  SFChatPackage
//
//  Created by Vivek Kumar on 28/07/25.
//

import Foundation
import SMIClientUI
import SwiftUICore
import SwiftUI

@MainActor
public struct ConversationView: View {
    public init() {}
    @State var state = SFChat.shared.state
    @State var isReady = SFChat.shared.state.isConfigured
    @State var now = Date()

    let timer = Timer.publish(every: 3, on: .current, in: .common).autoconnect()
    
    public var body: some View {
        
        VStack{
            if(SFChat.shared.state.isConfigured){
                Interface(SFChat.shared.config!)
                    .background(Color(hex: SFChat.shared.theme?.primaryContainer ?? "#FFFFFF"))
            } else {
                Text("Loading...\(isReady) \(now)")
                    .foregroundColor(Color(hex: SFChat.shared.theme?.onPrimary ?? "#000000"))
                    .onReceive(timer) { _ in
                        self.now = Date()
                    }
            }
        }
        .background(Color(hex: SFChat.shared.theme?.primary ?? "#F5F5F5")) // overall background
    }
}

@MainActor
public struct ConversationContentView: View {
    @State var config: UIConfiguration = SFChat.shared.config!
    
    public var body: some View {
        Interface(config)
            .background(Color(hex: SFChat.shared.theme?.primaryContainer ?? "#FFFFFF"))
    }
}
