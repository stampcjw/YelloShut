//
//  AppDelegate.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/10/23.
//

import UIKit
import Contacts
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        CNContactStore().requestAccess(for: .contacts) { (access, error) in
            print("Access: \(access)")
        }
        
        FirebaseApp.configure()
        
        return true
    }

    func switchIntro() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        let nvc = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
    
    func switchMain() {
//        let storyboard = UIStoryboard(name: "NaverMap", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "NaverMapViewController")
        
        let storyboard = UIStoryboard(name: "NaverMap", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
//        let nvc = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }


}

