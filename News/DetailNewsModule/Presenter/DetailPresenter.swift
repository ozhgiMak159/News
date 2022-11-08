//
//  DetailPresenter.swift
//  News
//
//  Created by Maksim  on 29.10.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setComment(news: Post?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, news: Post?)
    func setComment()
}

final class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var news: Post?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, news: Post?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.news = news
    }
    
    func setComment() {
        view?.setComment(news: news)
    }

}
