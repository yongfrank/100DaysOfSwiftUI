//
//  ViewController.swift
//  Project1
//
//  Created by Frank Chu on 4/30/22.
//

import UIKit

class ViewController: UITableViewController {
    // MARK: - Store All Pictures
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // MARK: - Pictures in App
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        print("DEBUG: pictures", pictures)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButton))
    }
    
    @objc func shareButton() {
        let shareString = "Please Share the App Storm Viewer with your friends"
        let viewcontroller = UIActivityViewController(activityItems: [shareString], applicationActivities: [])
        viewcontroller.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(viewcontroller, animated: true)
    }
    
    
    // MARK: - Override to make same name function and override it!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // vc means ViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

