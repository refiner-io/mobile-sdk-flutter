import Flutter
import UIKit
import RefinerSDK

public class RefinerFlutterPlugin: NSObject, FlutterPlugin {
    
    var channel: FlutterMethodChannel!
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = RefinerFlutterPlugin()
        instance.channel = FlutterMethodChannel(name: "refiner_flutter", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel:  instance.channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String : NSObject]{
            switch call.method {
            case "initialize":
                self.initialize(projectId: args["projectId"] as! String, debugMode: args["debugMode"] as! Bool)
            case "setProject":
                self.setProject(projectId: args["projectId"] as! String)
            case "identifyUser":
                self.identifyUser(userId: args["userId"] as! String, userTraits: args["userTraits"] as! [String : NSObject]?, locale: args["locale"] as? String, signature: args["signature"] as? String)
            case "trackEvent":
                self.trackEvent(eventName: args["eventName"] as! String)
            case "trackScreen":
                self.trackScreen(screenName: args["screenName"] as! String)
                
            case "showForm":
                self.showForm(formUuid: args["formUuid"] as! String, force: args["force"] as! Bool)
            case "dismissForm":
                self.dismissForm(formUuid: args["formUuid"] as! String)
            case "closeForm":
                self.closeForm(formUuid: args["formUuid"] as! String)
            case "addToResponse":
                self.addToResponse(contextualData: args)
            default:
                result(FlutterMethodNotImplemented)
            }
            result("success")
            
        } else {
            switch call.method {
            case "resetUser":
                self.resetUser()
            case "ping":
                self.ping()
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    public func initialize(projectId:String, debugMode:Bool) {
        Refiner.instance.initialize(projectId: projectId, debugMode: debugMode)
        registerCallbacks()
    }
    
    public func setProject(projectId:String) {
        print("setProject:")
        print(projectId)
        Refiner.instance.setProject(with: projectId)
    }
    
    public func identifyUser(userId:String, userTraits:[String : NSObject]?, locale:String?, signature:String?)  {
        do{
            try Refiner.instance.identifyUser(userId: userId,userTraits: userTraits,locale: locale ,signature: signature)
        } catch {
        }
    }
    public func resetUser() {
        Refiner.instance.resetUser()
    }
    public func trackEvent(eventName:String) {
        Refiner.instance.trackEvent(name: eventName)
    }
    public func trackScreen(screenName:String) {
        Refiner.instance.trackScreen(name: screenName)
    }
    public func ping() {
        Refiner.instance.ping()
    }
    
    public func showForm(formUuid:String, force:Bool) {
        Refiner.instance.showForm(uuid: formUuid, force: force)
    }
    public func dismissForm(formUuid:String) {
        Refiner.instance.dismissForm(uuid: formUuid)
    }
    public func closeForm(formUuid:String) {
        Refiner.instance.closeForm(uuid: formUuid)
    }
    public func addToResponse(contextualData:[String : Any]) {
        Refiner.instance.addToResponse(data: contextualData)
    }
    private func registerCallbacks() {
        Refiner.instance.onBeforeShow = { formId, formConfig in
            let args:[String : Any?]=["formId":formId,"formConfig":formConfig]
            self.sendEvent(eventName: "onBeforeShow", params:args)
        }
        Refiner.instance.onShow = { formId in
            let args:[String : Any?]=["formId":formId]
            self.sendEvent(eventName: "onShow", params:args)
        }
        Refiner.instance.onClose = { formId in
            let args:[String : Any?]=["formId":formId]
            self.sendEvent(eventName: "onClose", params:args)
        }
        Refiner.instance.onComplete = { formId, formData in
            let args:[String : Any?]=["formId":formId,"formData":formData]
            self.sendEvent(eventName: "onComplete", params:args)
        }
        Refiner.instance.onDismiss = { formId in
            let args:[String : Any?]=["formId":formId]
            self.sendEvent(eventName: "onDismiss", params:args)
        }
        Refiner.instance.onNavigation = { formId, formElement, progress in
            let args:[String : Any?]=["formId":formId,"formElement":formElement,"progress":progress]
            self.sendEvent(eventName: "onNavigation", params:args)
        }
    }
    private func sendEvent(eventName:String, params:[String : Any?]?) {
        self.channel?.invokeMethod(eventName, arguments: params)
    }
}
