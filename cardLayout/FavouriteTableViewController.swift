import UIKit

class FavouriteTableViewController: UITableViewController {
    var recipe_list: Array<Recipe>!
    
    fileprivate let cellId = "cellID"
            
            
            override func viewDidLoad() {
                super.viewDidLoad()
                tableView.backgroundColor =  #colorLiteral(red: 1, green: 0.9663686226, blue: 0.9621092037, alpha: 1)
                self.recipe_list = RecipeList().getFavouriteRecipe()
                
            }
            
            override func viewWillAppear(_ animated: Bool) {
                
                super.viewWillAppear(animated) // No need for semicolon
                self.recipe_list = RecipeList().getFavouriteRecipe()
                self.tableView?.reloadData()
            }
            
            override func numberOfSections(in tableView: UITableView) -> Int
            {
                return 1
            }
            
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // #warning Incomplete implementation, return the number of rows
                return  self.recipe_list.count
            }

            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")

                if cell == nil
                {
                    cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellID")
                }
               
                let recipe = self.recipe_list[indexPath.row]
                let name =  recipe.name
                cell!.textLabel?.text = name
                cell!.textLabel?.textAlignment = .center
                cell!.textLabel?.font =  UIFont(name:"Chalkboard SE",size:16)
                cell!.textLabel?.textColor = #colorLiteral(red: 0.5799615383, green: 0.5800500512, blue: 0.5799494386, alpha: 1)
                cell!.backgroundColor = #colorLiteral(red: 1, green: 0.9663686226, blue: 0.9621092037, alpha: 1)
                
                
    //            cell!.detailTextLabel?.text = train.source + " | " + train.destination
                
                
                return cell!
            }


        // method to run when table view cell is tapped
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //         Segue to the second view controller
            self.performSegue(withIdentifier: "recipeDetail", sender: self)
        }

        // This function is called before the segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            let recipeDetailControllerViewController = segue.destination as! RecipeDetailControllerViewController

            let index = tableView.indexPathForSelectedRow?.row
            let recipe = self.recipe_list[index!]
            recipeDetailControllerViewController.recipe = recipe
            
        }

        override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
        {
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in

                let recipe = self.recipe_list![indexPath.row]
                 
                let deleteMenu = UIAlertController(title: nil, message: "Remove From Favourite", preferredStyle: .actionSheet)
                    
                let deleteStopAction = UIAlertAction(title: "Delete", style: .default, handler: {(action:UIAlertAction) in
                    self.deleteRecipeButtonTapped(id:recipe.id)
                })
                
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    
            deleteMenu.addAction(deleteStopAction)
            deleteMenu.addAction(cancelAction)
                     
            self.present(deleteMenu, animated: true, completion: nil)
          })
            // 5
            return [deleteAction]
        }
        
        @objc func deleteRecipeButtonTapped(id: String){
            RecipeList().deleteFavRecipe(id)
            let sqlitedb = SqliteDb()
            sqlitedb.delete_recipe(id: id)
            reloadRecipeData()
            navigationController?.popViewController(animated: true)
        }


}
