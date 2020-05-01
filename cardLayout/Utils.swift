
import Foundation

func reloadRecipeData() {
    SqliteDb().fetch_recipe_list()
    

}

func create_initial_fav_recipe_data() {
    
    let  sqlitedb = SqliteDb()
    var recipe_id = sqlitedb.add_recipe(id: "935", name: "abc")
}
