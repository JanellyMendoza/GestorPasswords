//
//  AppDelegate.swift
//  Gestor de Contraseñas
//
//  Created by Janelly on 26/02/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
        var window: UIWindow?
        var appCoordinator : AppCoordinator?
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            self.appCoordinator = AppCoordinator(window: window!)
            appCoordinator?.startCoordinator()
            
            return true
        }
    }
    
    

