//
//  ShoppingListTableViewController.swift
//  Consolidation3
//
//  Created by Frank Chu on 1/18/23.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shopping List"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItemToShoppingList))
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearArray))
        let shareButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareList))
        self.navigationItem.leftBarButtonItem = clearButton
        self.navigationItem.rightBarButtonItems = [addButton, shareButton]
        
//        self.toolbarItems = [addButton, self.editButtonItem]
//        self.navigationController?.isToolbarHidden = false
    }
    
    @objc func shareList() {
        let shareText = self.shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func clearArray() {
        self.shoppingList.removeAll()
        self.tableView.reloadData()
    }
    
    @objc func addItemToShoppingList() {
        let vc = UIAlertController(title: "Add Item", message: "Shopping List", preferredStyle: .alert)
        vc.addTextField()
        let submitAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak vc] _ in
            guard let self = self else { return }
            guard let newItem = vc?.textFields?.first?.text else { return }
//            guard let newItem = vc.textFields?.first?.text else { return }
            self.shoppingList.insert(newItem, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        vc.addAction(submitAction)
        present(vc, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.shoppingList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingList", for: indexPath)

        // Configure the cell...
        var context: UIListContentConfiguration = cell.defaultContentConfiguration()
        context.text = self.shoppingList[indexPath.row]
        cell.contentConfiguration = context
        return cell
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
