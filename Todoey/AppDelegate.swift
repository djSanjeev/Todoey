//
//  AppDelegate.swift
//  Todoey
//
//  Created by Sanjeev Vyas on 02/07/19.
//  Copyright © 2019 Sanjeev Vyas. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        print(Realm.Configuration.defaultConfiguration)
        
      
        
        do {
            _ = try Realm()
           
            
        } catch {
           // print("Error initiliazing new realm ,\(error)")
        }
        
        
        return true
    }

    
    
    // MARK: UISceneSession Lifecycle
    
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
    
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//      
//    self.saveContext()
//    }
    
 
    // MARK: - Core Data Saving support
    
   
    
}
