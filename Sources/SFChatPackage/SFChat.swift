import SMIClientUI
import SwiftUICore
import SwiftUI 

public class SFChat : @unchecked Sendable {
    let conversationID = UUID()
    let state = SFChatState()
    public static let shared = SFChat()
    
    var config: UIConfiguration?
    var theme: SFTheme?
    
    public init() {}
    
    public func setup(conf: SFConfig) {
        let orgId = conf.organizationID
        let developerName = conf.developerName
        let conversationId = UUID(uuidString: conf.conversationId)!
        let url = URL(string: conf.url)!
        DispatchQueue.main.async {
            SFChat.shared.config = UIConfiguration(serviceAPI: url,
                                                   organizationId: orgId,
                                                   developerName: developerName,
                                                   conversationId: conversationId)
            print("Config done \n \(String(describing: SFChat.shared.config))")
            SFChat.shared.state.isConfigured = true
            SFChat.shared.state.objectWillChange.send()
        }
    }
    
    public func setupTheme(conf: SFTheme) {
        SFChat.shared.theme = conf
        print("Theme applied: \(conf)")
        
        DispatchQueue.main.async {
            SFChat.shared.state.objectWillChange.send()
        }
    }
    
    public func testSetup() {
        let configData = StaticData().config
        let url = URL(string: configData.url)!
        DispatchQueue.main.async {
            SFChat.shared.config = UIConfiguration(serviceAPI: url,
                                                   organizationId: configData.organizationID,
                                                   developerName: configData.developerName,
                                                   conversationId: SFChat.shared.conversationID)
            print("Config done \n \(String(describing: SFChat.shared.config))")
            SFChat.shared.state.isConfigured = true
            SFChat.shared.state.objectWillChange.send()
        }
    }
    public func checkIfConnected(callback:@escaping (Bool) -> Void) {
        if (SFChat.shared.config != nil) {
            callback(true)
        } else {
            callback(false)
        }
    }
}
