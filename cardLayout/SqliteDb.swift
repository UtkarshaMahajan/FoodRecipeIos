import Foundation
import SQLite3

class SqliteDb {

var db: OpaquePointer?

init() {
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
       .appendingPathComponent("RecipeDatabase.sqlite")
    
    //opening the database
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
       print("error opening database")
    }
}

func execute_query(query: String) -> Bool {
        if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK {
           let errmsg = String(cString: sqlite3_errmsg(db)!)
           print("error creating table: \(errmsg)")
            return false
    }
        else {
            return true
    }
}
    
    func create_recipe_table() {
            let create_recipe_table = """
        CREATE TABLE  IF NOT EXISTS Recipe (
                id text,
                name text,
                PRIMARY KEY (id)
            );
        """
        _ = self.execute_query(query: create_recipe_table)
        
    }
    
    func add_recipe(id: String, name: String) -> String {
        
        let str = NSUUID().uuidString
        let array = str.components(separatedBy: "-")
        let train_line_id = array[0]
        
        let create_recipe = """
        INSERT INTO Recipe VALUES ('\(id)', '\(name)');
        """
        _ = self.execute_query(query: create_recipe)
        return train_line_id
        
    }
    
    func delete_recipe(id: String) {
         let delete_recipe = """
             DELETE FROM Recipe where  id = '\(id)';
             """
        _ = self.execute_query(query: delete_recipe)
    }
    
    func fetch_recipe_list() {
          let recipe_list_query = "select * from Recipe ORDER BY name"
        self.fetch_data(query: recipe_list_query, tabel_name: "Recipe")
        
    }
    
    func fetch_data(query: String, tabel_name:String) {

      // 1
      if sqlite3_prepare_v2(db, query, -1, &db, nil) ==
          SQLITE_OK {
        // 2
        while sqlite3_step(db) == SQLITE_ROW {
            if tabel_name == "Recipe" {
                
                let id = String(describing: String(cString: sqlite3_column_text(db, 0)))
                let name = String(describing: String(cString: sqlite3_column_text(db, 1)))
                if recipe_dict.index(forKey: id) == nil {
                    get_recipe_details(recipe_id:id)
                    sleep(6)
                }
                RecipeList().addFavouriteRecipe(recipe_dict[id]!)

                }
            
            }
        }
    }
    
    
    func delete_tables() {
        let delete_recipe = "DROP TABLE IF EXISTS Recipe;"
        _ = self.execute_query(query: delete_recipe)
        
    }
    
}
   
