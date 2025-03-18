import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(WatchSyncPlugin)
public class WatchSyncPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "WatchSyncPlugin"
    public let jsName = "WatchSync"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "pushDataToWatch", returnType: CAPPluginReturnPromise)
    ]


    @objc func pushDataToWatch(_ call: CAPPluginCall) {

    }
}
