//
//  MainNewsPresenter.swift
//  News
//
//  Created by Maksim  on 28.10.2022.
//

import Foundation

protocol MainNewsViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainNewsPresenterProtocol: AnyObject {
    init(view: MainNewsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func fetchData()
    var news: [Post]? { get set }
    func tapOnTheNew(comment: Post)
}


final class MainNewsPresenter: MainNewsPresenterProtocol {
   
    var view: MainNewsViewProtocol?
    var news: [Post]?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    
    init(view: MainNewsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        fetchData()
    }

    func tapOnTheNew(comment: Post) {
        router?.showDetail(comment: comment)
    }
    
    
    func fetchData() {
        networkService.getComments { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.news = news?.data
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }

}
