//
//  TableViewController.swift
//  Project7
//
//  Created by Frank Chu on 1/19/23.
//

import UIKit
import Combine


class TableViewController: UITableViewController {

    var petitions = [Petition]()
    var searchActive = false
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        if self.navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    // We're OK to parse.
                    print("=>data", data)
                    self.parse(json: data)
                    return
                }
            }
            self.showError()
        }
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//                guard let data = data else { return }
//                guard let self = self else { return }
//                DispatchQueue.main.sync {
//                    // self.petitions = jsonPetitions.results
//                    self.parse(json: data)
//                }
//            }.resume()
//        }
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credit", style: .plain, target: self, action: #selector(showCredit))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFiltered))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func showFiltered() {
        let filterAlert = UIAlertController(title: "Filter", message: "Enter Filter String", preferredStyle: .alert)
        filterAlert.addTextField()
        filterAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak filterAlert] _ in
            guard let self = self else { return }
            guard let text = filterAlert?.textFields?.first?.text else {
                return
            }
            if text == "" {
                self.searchActive = false
                self.filteredPetitions = self.petitions
                self.tableView.reloadData()
                return
            }
            
            DispatchQueue.global().async {
                print("inside async")
                self.filteredPetitions = self.petitions.filter({ petition in
                    petition.title.lowercased().contains(text.lowercased())
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    print("5s passed")
                }
            }
            print("Out async")
            
            DispatchQueue.main.async {
                print("main.async")
                if !self.filteredPetitions.isEmpty {
                    self.searchActive = true
                    self.tableView.reloadData()
                } else {
                    let empty = UIAlertController(title: "Empty", message: "No result", preferredStyle: .alert)
                    empty.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(empty, animated: true)
                }
            }
        }))
        present(filterAlert, animated: true)
    }
    
    @objc func showCredit() {
        let credit = UIAlertController(title: "Credit", message: "Data comes from \"We The People API\" of the Whitehouse", preferredStyle: .alert)
        credit.addAction(UIAlertAction(title: "OK", style: .default))
        present(credit, animated: true)
    }
    
//    func dataDownload(url: URL) async -> Data? {
//        if let (data, response) = try? await URLSession.shared.data(from: url) {
//            print(response)
//            return data
//        }
//        return nil
//    }
    
    func parse(json: Data) {
        if let jsonPetitions = try? JSONDecoder().decode(Petitions.self, from: json) {
            self.petitions = jsonPetitions.results
            self.filteredPetitions = self.petitions
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Load Error", message: "Try again, please.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredPetitions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petitionToBeShown: Petition = self.filteredPetitions[indexPath.row]
        
        // Configure the cell...
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()
        content.text = petitionToBeShown.title
        // https://developer.apple.com/documentation/uikit/uitableviewcell/1623273-detailtextlabel
        content.secondaryText = petitionToBeShown.body
        
        cell.contentConfiguration = content
        
//        cell.textLabel?.text = petition.title
//        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        let detailPetition = petitions[indexPath.row]
        detailVC.petition = detailPetition
        self.navigationController?.pushViewController(detailVC, animated: true)
        
//        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
//            detailVC.petition = petitions[indexPath.row]
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
