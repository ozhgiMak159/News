//
//  RouterTest.swift
//  NewsTests
//
//  Created by Maksim  on 30.10.2022.
//

import XCTest
@testable import News

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        self.pushViewController(viewController, animated: animated)
    }
}

class RouterTest: XCTestCase {

    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AssemblyModuleBuilder()
    
    override func setUp() {
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }

    override func tearDown() {
        router = nil
    }
    
    func testRouter() {
        router.showDetail(comment: nil)
        let detailViewController = navigationController.presentedVC
        
        XCTAssertTrue(detailViewController is DetailNewsViewController)
    }
}
