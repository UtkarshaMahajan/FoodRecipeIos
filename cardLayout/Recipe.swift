import Foundation

class Recipe {
    
    var id:String
    var name:String
    var total_time_minutes: String = "0"
    var thumbnail_url: String
    var instruction : [String] = []
    var ingredients : [String] = []
    var nutrition = Dictionary<String, String>()
    var user_ratings = Dictionary<String, Int>()
    
    init(id:String, name:String, total_time_minutes:String, thumbnail_url:String) {
        self.id = id
        self.name = name
        self.total_time_minutes = total_time_minutes
        self.thumbnail_url = thumbnail_url
        
    }
    
    func addInstruction(instruction:String) {
        self.instruction.append(instruction)
    }
    func addIngredients(ingredients:String) {
        self.ingredients.append(ingredients)
    }
    func addNutrition(nutrient:String, value:String) {
        self.nutrition[nutrient] = value
    }
    
    func addUserRatings(key:String, value:Int) {
        self.user_ratings[key] = value
    }
    
}

