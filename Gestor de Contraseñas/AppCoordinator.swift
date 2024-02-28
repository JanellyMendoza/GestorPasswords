//
//  AppCoordinator.swift
//  Gestor de Contraseñas
//
//  Created by Janelly on 26/02/24.
//

import Foundation
import UIKit

protocol Coordinator{
    var childCoordinator : [Coordinator] {get set}//get obtener su valor, set asignarle un valor
    func startCoordinator()
}

class AppCoordinator : Coordinator{
    var childCoordinator: [Coordinator] = []
    var window : UIWindow
    
    init(window : UIWindow){
        self.window = window
    }
    
    //error aqui, usar el window
    func startCoordinator() {
        let navigationController = UINavigationController()
         let viewControllerCoordinator = ViewControllerCoordinator(navigationController: navigationController )
        childCoordinator.append(viewControllerCoordinator)
        viewControllerCoordinator.startCoordinator()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
}

