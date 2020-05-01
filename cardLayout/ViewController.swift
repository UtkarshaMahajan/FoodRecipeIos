import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var tags : String = "indian"
    
    override func viewDidLoad() {
        
        get_recipe_list(tags: tags)

        super.viewDidLoad()
        
//        set_initail_data(id:"935")
//        set_initail_data(id:"936")
//        set_initail_data(id:"946")
//        set_initail_data(id:"947")
//        set_initail_data(id:"948")
//        set_initail_data(id:"949")
//        set_initail_data(id:"950")
//        set_initail_data(id:"951")
//        set_initail_data(id:"952")
//        set_initail_data(id:"953")
//        set_initail_data(id:"955")
//        set_initail_data(id:"956")
        let sqlitedb = SqliteDb()
        sqlitedb.delete_tables()
        sqlitedb.create_recipe_table()
//        create_initial_fav_recipe_data()
//        reloadRecipeData()
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9209796488, blue: 0.9089956378, alpha: 1)
       
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sleep(9)
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let recipe_list = RecipeList().getRecipeList()
        print(recipe_list.count)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .vertical
        collectionView.backgroundColor = #colorLiteral(red: 0.906917908, green: 0.8352529364, blue: 0.8243844222, alpha: 1)
        collectionView.alwaysBounceVertical = true
        
        return recipe_list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let recipe_list = RecipeList().getRecipeList()
        
        let url = recipe_list[indexPath.row].thumbnail_url
        cell.setImage(from: url)
        
        cell.recipeName.text = recipe_list[indexPath.row].name
        cell.total_time.text = "\(recipe_list[indexPath.row].total_time_minutes) minutes"
        let user_ratings = recipe_list[indexPath.row].user_ratings
        cell.total_positive.text = user_ratings["count_positive"]?.description
        cell.total_negative.text = user_ratings["count_negative"]?.description
        
        //This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        cell.clipsToBounds = true
        let path = UIBezierPath(roundedRect: cell.bounds,
                                byRoundingCorners: [.topRight, .topLeft],
                                cornerRadii: CGSize(width: 20, height: 20))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        cell.layer.mask = maskLayer

       
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let recipeDetailController = storyboard?.instantiateViewController(withIdentifier: "RecipeDetailControllerViewController") as? RecipeDetailControllerViewController
        let recipe_list = RecipeList().getRecipeList()
        let recipe = recipe_list[indexPath.row]
        recipeDetailController?.recipe = recipe
        self.navigationController?.pushViewController(recipeDetailController!, animated: true)
        
    }
    

}

