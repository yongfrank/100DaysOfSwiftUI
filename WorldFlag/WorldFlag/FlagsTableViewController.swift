//
//  FlagsTableViewController.swift
//  WorldFlag
//
//  Created by Frank Chu on 1/4/23.
//

import UIKit
import SVGKit
import DiskCache


class FlagsTableViewController: UITableViewController {

    var flags = [Flag]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "World Flags"
        
        self.flags = FlagsClass.getJSON(for: "flags")!
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return flags.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "flags", for: indexPath)
        cell.textLabel?.text = self.flags[indexPath.row].emoji + self.flags[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            vc.selectedItem = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
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

class FlagsClass {
    
    /**
     diii
     - Parameters:
        - for: 1
        - fromInternet: bool
     
     - Note:
     Lists
     1. Good
     2. bad
     
     ```
     let url = "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/index.json"
     FlagsClass.getJSON(for: url, fromInternet: true) { flags in
        for (flag, index) in flags?.enumerated() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "flags", for: index)
            cell.textLabel?.text = "flags"
            self.tableView = cell
        }
     }
     ```
     */
    static func getJSONFromInternet(for fileName: String, fromInternet: Bool = false, completionBlock: @escaping ([Flag]?) -> Void) {
        var flags: [Flag]?
        if fromInternet {
            if let url = URL(string: fileName) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        print(data.count)
                        flags = try? JSONDecoder().decode([Flag].self, from: data)
                        completionBlock(flags)
                    }
                }.resume()
            }
            
        } else {
            if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: fileUrl)
                    flags = try JSONDecoder().decode([Flag].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func getJSON(for fileName: String) -> [Flag]? {
        var flags: [Flag]?
        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                flags = try JSONDecoder().decode([Flag].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return flags
    }
}
