//
//  AppAbout.swift
//  Pods-SwiftWalle_Example
//
//  Created by Don.shen on 2020/3/27.
//

import Foundation

public struct App {
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    public static var appShortVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public static var appVersion: String{
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    public static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    public static var bundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    public static var bundleName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    public static var appStoreURL: URL {
        return URL(string: "your URL")!
    }
    
    public static var appVersionAndBuild: String {
        let version = appVersion, build = appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public static var screenWidth: CGFloat{
        return UIScreen.main.bounds.size.width
    }
    
    public static var screenHeight: CGFloat{
        return UIScreen.main.bounds.size.height
    }
    public static var statusBarHeight: CGFloat{
        return App.isX ? 44.0 : 20.0 // 处理statusBarHidden的情况
    }
    public static var systemStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    public static var navigationBarHeight: CGFloat{
        return 44.0
    }
    public static var tabBarHeight: CGFloat{
        return 44.0
    }
    public static var naviStatusHeight: CGFloat{
        return App.statusBarHeight + App.navigationBarHeight
    }
    public static var screenHeightWithoutStatusBar: CGFloat {
        if UIInterfaceOrientation.portrait.isPortrait{
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }
    public static var isX: Bool{
        if #available(iOS 11.0, *){
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom != 0
        }else{
            return false
        }
    }
    public static var safeAreaBottom: CGFloat{
        return isX ? 34.0 : 0.0
    }
}
public struct Platform {
    public static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}
public func VLog<T>(_ message: T, file: String = #file, funcName: String = #function, line: Int = #line){
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("file:\(fileName), funcname:\(funcName), line:\(line), message:\(message)")
    #endif
}
