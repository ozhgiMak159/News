//
//  DetailNewsViewController.swift
//  News
//
//  Created by Maksim  on 29.10.2022.
//

import UIKit

final class DetailNewsViewController: UIViewController {
    
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var postText: UITextView!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setComment()
    }

}

extension DetailNewsViewController: DetailViewProtocol {
    func setComment(news: Post?) {
        postText.text = news?.content
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: news?.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.imagePost.image = UIImage(data: imageData)
            }
        }
    }
    
}
