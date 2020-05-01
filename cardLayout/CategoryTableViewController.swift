
import UIKit

class CategoryTableViewController: UITableViewController {
        
        fileprivate let cellId = "cellID"
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
             tableView.backgroundColor =  #colorLiteral(red: 1, green: 0.9663686226, blue: 0.9621092037, alpha: 1)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            super.viewWillAppear(animated) // No need for semicolon
            
            self.tableView?.reloadData()
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int
        {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return  categoryList.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")

            if cell == nil
            {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellID")
            }
            let category = categoryList[indexPath.row]
            let name =  category["display_name"]
            cell!.textLabel?.text = name
            cell!.textLabel?.textAlignment = .center
            cell!.textLabel?.font =  UIFont(name:"Papyrus",size:16)
            cell!.textLabel?.textColor = #colorLiteral(red: 0.5799615383, green: 0.5800500512, blue: 0.5799494386, alpha: 1)
            cell!.backgroundColor = #colorLiteral(red: 1, green: 0.9663686226, blue: 0.9621092037, alpha: 1)
            
//            cell!.detailTextLabel?.text = train.source + " | " + train.destination
            
            
            return cell!
        }

    // method to run when table view cell is tapped
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //         Segue to the second view controller
            self.performSegue(withIdentifier: "recipeList", sender: self)

            
            
        }

        // This function is called before the segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as? ViewController


            let index = (tableView.indexPathForSelectedRow?.row)!
            let category = categoryList[index]

            targetController?.tags = category["name"] ?? "indian"

        }

        
}
