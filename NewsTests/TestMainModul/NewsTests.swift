//
//  NewsTests.swift
//  NewsTests
//
//  Created by Maksim  on 28.10.2022.
//

import XCTest
@testable import News

class MockView: MainNewsViewProtocol {
    func success() {}
    func failure(error: Error) {}
}

class MockNetworkService: NetworkServiceProtocol {
    var comments: [Post]!
    init() {}
    
    convenience init(comments: [Post]?) {
        self.init()
        self.comments = comments
    }
    
    func getComments(completion: @escaping (Result<News?, Error>) -> Void) {
        if let comments = comments {
            let data = News(data: comments)
            completion(.success(data))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}


final class NewsTests: XCTestCase {

    var view: MockView!
    var presenter: MainNewsPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Post]()
    
    override func setUp() {
        let nav = UINavigationController()
        let assembly = AssemblyModuleBuilder()
        router = Router(navigationController: nav, assemblyBuilder: assembly)
    }

    override func tearDown() {
        view = nil
        networkService = nil
        presenter = nil
    }
    
    func testGetSuccessComents() {
        let comment = Post(title: "", content: "", date: "", author: "", imageUrl: "")
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService(comments: comments)
        presenter = MainNewsPresenter(view: view, networkService: networkService, router: router)
        
        var catchComments: [Post]?
        
        networkService.getComments { result in
            switch result {
            case .success(let comments):
                catchComments = comments?.data
            case.failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchComments?.count, 0)
        XCTAssertEqual(catchComments?.count, comments.count)
        
    }
    
    func testGetFailerComents() {
        let url = "https://static.inshorts.com/inshorts/images/v1/variants/jpg/m/2022/10_oct/28_fri/img_1666967113140_759.jpg?"
        let comment = Post(title: "Foo", content: "Baz", date: "28 Oct 2022,Friday", author: "Max", imageUrl: url)
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService()
        presenter = MainNewsPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        networkService.getComments { result in
            switch result {
            case .success(_):
               break
            case.failure(let error):
                catchError = error
            }
        }
        
       XCTAssertNotNil(catchError)
        
    }
    

}
