//
//  Coordinator.swift
//  git
//
//  Created by mostfa on 12/12/19.
//  Copyright © 2019 mostfa. All rights reserved.
//


import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
