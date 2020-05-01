import Foundation
import UIKit

let from:Int = 10
let sizes:Int = 13

let headers = [
  "x-rapidapi-host": "tasty.p.rapidapi.com",
  "x-rapidapi-key": "7b53c5281bmsh72841bb3fb4f196p155714jsn4618bf55e1d8"
]


func get_recipe_list(tags:String) {
    var url = "https://tasty.p.rapidapi.com/recipes/list?from=\(from)&sizes=\(sizes)"
    if (tags != nil){
          url = "https://tasty.p.rapidapi.com/recipes/list?tags=\(tags)&from=\(from)&sizes=\(sizes)"
    }
    print(url)
    let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print(error)
      } else {
        if var jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
//                print(jsonObj)
            populate_recipe_from_respone(jsonObj!)

            }
      }
    })

    dataTask.resume()
}

func get_recipe_details(recipe_id:String) {
    let url = "https://tasty.p.rapidapi.com/recipes/detail?id=\(recipe_id)"
    
    let request = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .useProtocolCachePolicy,  timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    print(url)
    print("recipe details")
    

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print(error)
      } else {
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                populate_recipe_from_respone(jsonObj!)


            }
      }
    })


    dataTask.resume()
}

func get_tags_list() {}
func get_recipe_list_from_tags() {

}

func populate_recipe_from_respone(_ jsonObj : NSDictionary) {
    if let results = jsonObj.value(forKey: "results") as? NSArray {

        for raw_recipe_data in results {

        //converting the element to a dictionary
            if let recipe_dict = raw_recipe_data as? NSDictionary {
                
                var id = "\(recipe_dict["id"]!)"
                
                
                var name = recipe_dict["name"]!

//                var total_time_minutes = (recipe_dict["total_time_minutes"] != nil) ? "\(recipe_dict["total_time_minutes"]!)" : ""
                
                var total_time_minutes = recipe_dict["total_time_minutes"]
                if (total_time_minutes != nil) {
                    total_time_minutes = "\(total_time_minutes!)"
                }
                else {
                    total_time_minutes = "30"
                }
                if (total_time_minutes as! String == "<null>") {
                    total_time_minutes = "30"
                }
            
                var thumbnail_url = (recipe_dict["thumbnail_url"] != nil) ? recipe_dict["thumbnail_url"]! : ""

                var nutrition : [String:String] = [:]
                var nutrition_dict = recipe_dict["nutrition"] as? NSDictionary
                if let nutrition_dict = recipe_dict["nutrition"] as? NSDictionary {
                    for (key,value)  in nutrition_dict  {
                        nutrition[key as! String]  = "\(value)"
                    }
                }
                
                var instruction_list : [String] = []
                if let instructions_array = recipe_dict["instructions"] as? NSArray {
                     for  instruction in instructions_array {
                        if let instruction_dict = instruction as? NSDictionary {
                            instruction_list.append((instruction_dict["display_text"] as? String)!)
                        }

                     }
                }
                var ingredient_list : [String] = []
                if let sectionArray = recipe_dict["sections"] as? NSArray {
                     for section in sectionArray {
                        if let section_dict = section as? NSDictionary {
                            if let componentArray = section_dict["components"] as? NSArray {
                                for component in componentArray {
                                    if let component_dict = component as? NSDictionary {
                                        if let ingredient_dict = component_dict["ingredient"] as? NSDictionary {
                                            ingredient_list.append((ingredient_dict["name"] as? String)!)

                                        }
                                    }
                                }
                            }
                        }

                     }
                }
                var user_ratings : [String:Int] = [:]
                var user_ratings_dict = recipe_dict["user_ratings"] as? NSDictionary
                if let user_ratings_dict = recipe_dict["user_ratings"] as? NSDictionary {
                    for (key,value)  in user_ratings_dict  {
                        if (key as! String == "score")  {
                           continue
                        }
                        user_ratings[key as! String]  = value as! Int
                    }
                }
                
                final_data(id: id, name: name as! String, total_time_minutes: total_time_minutes as! String, thumbnail_url: thumbnail_url as! String, ingredient_list: ingredient_list, instruction_list: instruction_list, nutrition : nutrition, user_ratings: user_ratings)

//                break

            }
        }
    }

}


func set_initail_data(id:String) {
    var id = id
    var name = "Homemade Chicken Tikka Masala"
    var total_time_minutes = "102"
    var thumbnail_url = "https://img.buzzfeed.com/video-api-prod/assets/d03461e6d185483da8317cf9ee03433e/BFV18861_ChickenTikkaMasala-ThumbA1080.jpg"
    var nutrition = ["updated_at": "2019-12-06T07:02:05+01:00", "fat": "33", "sugar": "9", "calories": "472", "fiber": "4", "protein": "33", "carbohydrates": "17"]
    var instruction_list = ["Slice the chicken into bite-sized chunks. Combine the cubed chicken with the yogurt, lemon juice, garlic, ginger, salt, cumin, garam masala, and paprika and stir until well-coated.", "Cover and refrigerate for at least 1 hour, or overnight.", "Preheat the oven to 500°F (260°C). Line a high-sided baking pan or roasting tray with parchment paper.", "Place the marinated chicken pieces on bamboo or wooden skewers, then set them over the prepared baking pan, making sure there is space underneath the chicken to help distribute the heat more evenly. Bake for about 15 minutes, until slightly dark brown on the edges.", "Make the sauce: Heat the oil in a large pot over medium heat, then sauté the onions, ginger, and garlic until tender but not browned. Add the cumin, turmeric, coriander, paprika, chili powder, and garam masala and stir constantly for about 30 seconds, until the spices are fragrant. Stir in the tomato puree, tomato sauce, and 1 ¼ cups of water, then bring to a boil and cook for about 5 minutes. Pour in the cream.", "Remove the chicken from the skewers and add to the sauce, cooking for another 1-2 minutes. Garnish with cilantro and serve over rice or alongside naan bread.", "Enjoy!"]
    var ingredient_list = ["boneless, skinless chicken breast", "plain yogurt", "lemon juice", "garlic", "minced ginger", "salt", "ground cumin", "garam masala", "paprika", "oil", "large onion", "minced ginger", "garlic", "ground cumin", "ground turmeric", "ground coriander", "paprika", "chili powder", "garam masala", "tomato puree", "tomato sauce", "water", "heavy cream", "fresh cilantro", "cooked rice", "naan bread", "Bamboo or wooden skewers"]
    
    var recipe = Recipe(id: id, name: name, total_time_minutes: total_time_minutes, thumbnail_url: thumbnail_url)
    for ingredient in ingredient_list{
        recipe.addIngredients(ingredients: ingredient.capitalized)
    }
    for instruction in instruction_list{
        recipe.addInstruction(instruction: instruction)
    }
    if nutrition.removeValue(forKey: "updated_at") != nil {
        
    }
    
    for (key, value) in nutrition {
        if (key == "updated_at")  {
           continue
        }
        recipe.addNutrition(nutrient: key.capitalized, value: value.capitalized)
    }
    RecipeList().addRecipe(recipe)
    
    
}

func final_data(id: String, name: String, total_time_minutes: String, thumbnail_url: String,  ingredient_list: [String], instruction_list: [String],  nutrition : [String:String], user_ratings:[String:Int]) {
    var recipe : Recipe
    
    if recipe_dict.index(forKey: id) == nil {
        recipe = Recipe(id: id, name: name, total_time_minutes: total_time_minutes, thumbnail_url: thumbnail_url)
    }
    else {
        recipe = recipe_dict[id]!
       
    }
    
    
    for ingredient in ingredient_list {
        recipe.addIngredients(ingredients: ingredient.capitalized)
    }
    for instruction in instruction_list{
        recipe.addInstruction(instruction: instruction)
    }
    

    for (key, value) in nutrition {
        if (key == "updated_at")  {
           continue
        }
        recipe.addNutrition(nutrient: key, value: value.capitalized)
    }
    for (key, value) in user_ratings {
        recipe.addUserRatings(key: key, value: value)
    }
    if recipe_dict.index(forKey: id) == nil {
        RecipeList().addRecipe(recipe)
    }

}
