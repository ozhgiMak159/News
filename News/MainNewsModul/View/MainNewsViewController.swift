//
//  MainNewsViewController.swift
//  News
//
//  Created by Maksim  on 29.10.2022.
//

import UIKit

class MainNewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainNewsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MainNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension MainNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainNewsTableViewCell
        let news = presenter.news?[indexPath.row]
        cell.configure(post: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = presenter.news?[indexPath.row] else { return }
        presenter.tapOnTheNew(comment: news)
    }

}

extension MainNewsViewController: MainNewsViewProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
