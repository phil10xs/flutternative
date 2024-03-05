import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
 func getMessage(result: FlutterResult) {
          // Implement your logic for getting the message here
          let message = "Message from Swift code"
          if message.isEmpty {
          result(FlutterError(code: "UNAVAILABLE",
          message: "Message from Swift code is empty",
          details: nil))
          } else {
          result(message)
          }
        }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

     let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.example.flutternative", binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) in
      // This method is invoked on the UI thread.
      guard call.method == "getMessageFromNativeCode" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.getMessage(result: result)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
