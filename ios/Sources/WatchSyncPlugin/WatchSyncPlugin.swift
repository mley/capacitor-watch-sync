import Foundation
import Capacitor
import WatchConnectivity

@objc(WatchSyncPlugin)
public class WatchSyncPlugin: CAPPlugin, CAPBridgedPlugin, WCSessionDelegate {
    public let identifier = "WatchSyncPlugin"
    public let jsName = "WatchSync"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "initialize", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pushDataToWatch", returnType: CAPPluginReturnPromise)
    ]
    

    private var data: [String: Any]?
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
        
    @objc func pushDataToWatch(_ call: CAPPluginCall) {
        print("pushDataToWatch")
        if WCSession.isSupported() {
            if(WCSession.default.activationState != .activated) {
                WCSession.default.activate()
            }
        } else {
            call.reject("cap-watch-sync: WatchConnectivity is not supported on this device")
            return
        }

        guard let data = call.options as? [String: Any] else {
            call.reject("cap-watch-sync: Invalid data format")
            return
        }

        self.data = data
        do {
            try WCSession.default.updateApplicationContext(data)
            call.resolve()
        } catch {
            call.reject("cap-watch-sync: error updateApplicationContext: \(error.localizedDescription)")
        }
        
       
    }
    


    public func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        print("session: \(message)")
        notifyListeners("watchMessageReceived", data: message)
    }
    
    public func session(_ session: WCSession, activationDidCompleteWith state: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("cap-watch-sync: WatchConnectivity activation failed: \(error.localizedDescription)")
        } else {
            print("cap-watch-sync: WatchConnectivity activated successfully")
            guard let data = self.data else { return }
            do {
                try WCSession.default.updateApplicationContext(data)
                print("cap-watch-sync: updated application context successfully")
            } catch {
                print("cap-watch-sync: error updateApplicationContext: \(error.localizedDescription)")
            }

        }
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession) {
        print( "cap-watch-sync: WatchConnectivity session did become inactive")
    }
    public func sessionDidDeactivate(_ session: WCSession) {
        print( "cap-watch-sync: WatchConnectivity session did deactivate. Activating...")
        WCSession.default.activate()
    }
}
