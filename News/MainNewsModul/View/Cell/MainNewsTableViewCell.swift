//
//  MainNewsTableViewCell.swift
//  News
//
//  Created by Maksim  on 29.10.2022.
//

import UIKit

class MainNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textPostLabel: UILabel!
    @IBOutlet weak var dataPost: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    
    private func setupView() {
        viewMain.layer.cornerRadius = 15
        imagePost.layer.cornerRadius = 15
    }
    
    func configure(post: Post?) {
        textPostLabel?.text = post?.title
        dataPost?.text = post?.date
        setupView()
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: post?.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.imagePost.image = UIImage(data: imageData)
            }
        }
    }
    
}
