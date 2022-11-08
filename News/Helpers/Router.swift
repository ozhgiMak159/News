//
//  Router.swift
//  News
//
//  Created by Maksim  on 28.10.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(comment: Post?)
   
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController] 
        }
    }
    
    func showDetail(comment: Post?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(comment: comment, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
}
