import Foundation

var recipe_dict =  Dictionary<String, Recipe>()
var fav_recipe =  Dictionary<String, Recipe>()


class RecipeList {
    
    init(){}
    
    func addRecipe(_ recipe: Recipe) {
        recipe_dict[recipe.id] = recipe
    }
    
    func getRecipeList() -> [Recipe] {
        return Array(recipe_dict.values)
    }
    
    func addFavouriteRecipe(_ recipe: Recipe) {
        fav_recipe[recipe.id] = recipe
    }
    
    func getFavouriteRecipe() -> [Recipe] {
       // return Array(fav_recipe.values)
        return Array(fav_recipe.values)
    }
    
    func deleteRecipe(_ id: String) -> Bool{

        var deleted : Bool = false
        if let value = recipe_dict.removeValue(forKey: id) {
            deleted = true
        }
        return deleted
    }
    func deleteFavRecipe(_ id: String) -> Bool{

        var deleted : Bool = false
        if let value = fav_recipe.removeValue(forKey: id) {
            deleted = true
        }
        return deleted
    }
    
}
