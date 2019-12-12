//
//  MainCoordinator.swift
//  git
//
//  Created by mostfa on 12/12/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }

    func start() {
         let vc = ViewController.instantiate()
        vc.coordinator = self   
         navigationController.pushViewController(vc, animated: false)
     }
    
    func presentGitRepo(url:String) {
        print("im here")
        guard let url = URL(string: url) else {return}
        let vc = gitSafariViewController(url: url)
        vc.coordinator = self
        vc.delegate = vc 
        navigationController.pushViewController(vc, animated: true)
    }
    func dismissSafariController() {
        navigationController.popViewController(animated: true)
        
    }
}
