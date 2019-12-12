//
//  gitSafari.swift
//  git
//
//  Created by mostfa on 12/12/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import UIKit
import SafariServices
class gitSafariViewController: SFSafariViewController,SFSafariViewControllerDelegate {

    weak var coordinator: MainCoordinator?
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        coordinator?.dismissSafariController()
        
    }
    
}
