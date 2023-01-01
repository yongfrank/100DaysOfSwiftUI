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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
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
    
    @objc func shareTapped() {
        print("Share Tapped")
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        guard let imageName = self.selectedImage else {
            return
        }
        
        // Next we create a UIActivityViewController, which is the iOS method of sharing content with other apps and services.
        // We're passing an empty array into the second parameter, because our app doesn't have any services to offer.
        let viewcontroller = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        
        // This line of code tells iOS to anchor the activity view controller to the right bar button item (our share button),
        // but this only has an effect on iPad – on iPhone it's ignored.
        viewcontroller.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        // we already learned about present() in project 2. However, some other parts are new, so let me explain what they do:
        present(viewcontroller, animated: true)
    }
}
