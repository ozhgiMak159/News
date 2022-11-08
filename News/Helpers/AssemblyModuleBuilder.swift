//
//  AssemblyModuleBuilder.swift
//  News
//
//  Created by Maksim  on 28.10.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(comment: Post?, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainNewsViewController()
        let networkService = NetworkService()
        let presenter = MainNewsPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createDetailModule(comment: Post?, router: RouterProtocol) -> UIViewController {
        let view = DetailNewsViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, news: comment)
        view.presenter = presenter

        return view
    }

}

// MainNewsPresenter(view: view, networkService: networkService, router: router)
