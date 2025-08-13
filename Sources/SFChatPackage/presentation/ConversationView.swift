//
//  File.swift
//  SFChatPackage
//
//  Created by Vivek Kumar on 28/07/25.
//

import Foundation
import SMIClientUI
import SwiftUICore
@MainActor
public struct ConversationView:View {
    public init() {}
    @State var state = SFChat.shared.state
    @State var isReady = SFChat.shared.state.isConfigured
    
    @State var now = Date()

        let timer = Timer.publish(every: 3, on: .current, in: .common).autoconnect()
    
    public var body: some View {
        
        VStack{
            if(SFChat.shared.state.isConfigured){
                Interface(SFChat.shared.config!)
            }else{
                Text("Loading...\(isReady) \(now)").onReceive(timer) {_ in
                    self.now = Date()
                }
            }
        }
    }
}

@MainActor
public struct ConversationContentView:View {
//    public init() {}
    @State var config: UIConfiguration = SFChat.shared.config!
    
    public var body: some View {
        Interface(SFChat.shared.config!)
    }
}

