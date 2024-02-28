//
//  ViewControllerCoordinator.swift
//  Gestor de Contraseñas
//
//  Created by Janelly on 26/02/24.
//

import Foundation
import UIKit

class ViewControllerCoordinator: Coordinator{
    var childCoordinator: [Coordinator] = []
    var navigationController : UINavigationController
    
    init(navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    func startCoordinator() {
        let view = ViewController()
        let viewModel = ViewControllerModel()
        viewModel.coordinator = self
        view.viewModel = viewModel
        navigationController.setViewControllers([view], animated: true)
    }
}
