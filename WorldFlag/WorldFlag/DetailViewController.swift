//
//  DetailViewController.swift
//  WorldFlag
//
//  Created by Frank Chu on 1/4/23.
//

import UIKit
import Kingfisher
import SVGKit

public struct SVGImgProcessor: ImageProcessor {
    public var identifier: String = "com.appidentifier.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}

class DetailViewController: UIViewController {

    @IBOutlet var labelView: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var selectedPictureNumber = 0
    var selectedItem: Flag?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let selectedItem = selectedItem {
            let url = URL(string: selectedItem.image)!
            print(url)
            imageView.kf.setImage(with: url, options: [.processor(SVGImgProcessor())])
            labelView.text = selectedItem.emoji + selectedItem.name + selectedItem.code + selectedItem.unicode
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
    }
    
    @objc func shareFlag() {
        if let selectedItem = selectedItem {
            let sharingString = "This is the " + selectedItem.emoji + selectedItem.name + " " + selectedItem.code + " " + selectedItem.unicode
            let vc = UIActivityViewController(activityItems: [sharingString], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            
            present(vc, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
