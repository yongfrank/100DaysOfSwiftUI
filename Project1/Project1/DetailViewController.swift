//
//  DetailViewController.swift
//  Project1
//
//  Created by Frank Chu on 5/1/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(selectedPictureNumber) of \(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never
        view.insetsLayoutMarginsFromSafeArea = false

//        title = "Storm Viewer"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
