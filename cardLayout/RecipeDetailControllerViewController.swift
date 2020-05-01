
import UIKit

class RecipeDetailControllerViewController: UIViewController {
    
    var recipe:Recipe!

    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var segmentControlView: UISegmentedControl!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var fav_icon_image: UIImageView!
    
    let tap_fav_icon_image = UITapGestureRecognizer()
    
    @IBOutlet weak var video_player_image: UIImageView!
    
    let tap_video_player_image = UITapGestureRecognizer()
    
    @IBOutlet weak var recipeName: UILabel!
    
    var ingredientView: UIView!
    var methodView: UIView!
    var nutrientView: UIView!

    @IBOutlet weak var segmentScrollViewContainer: UIScrollView!

    var views : [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "dark-grey-texture.jpg")!)
        if (recipe != nil) {
            get_recipe_details(recipe_id:recipe.id)
            sleep(7)

            setImage(from:recipe.thumbnail_url)
            recipeName.text = recipe.name
            set_up_tap_gesture()
            
            views = [UIScrollView]()
            
            self.ingredientView = IngredientsViewController(recipe).view
            self.methodView = MethodViewController(recipe).view
            self.nutrientView = NutrientViewController(recipe).view
            
            self.views.append(self.ingredientView)
            self.views.append(self.methodView)
            self.views.append(self.nutrientView)


            for v in self.views {
                self.segmentScrollViewContainer.addSubview(v)
                v.topAnchor.constraint(equalTo:segmentScrollViewContainer.topAnchor).isActive = true
                v.leftAnchor.constraint(equalTo:segmentScrollViewContainer.leftAnchor).isActive = true
                v.bottomAnchor.constraint(equalTo: segmentScrollViewContainer.bottomAnchor, constant: -10).isActive = true
                v.widthAnchor.constraint(equalToConstant: segmentScrollViewContainer.frame.width).isActive = true
               
            }
            
            self.segmentScrollViewContainer.bringSubview(toFront: self.views[0])
            
//            let path = UIBezierPath(roundedRect: self.segmentScrollViewContainer.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
//            let mask = CAShapeLayer()
//            let rect = self.segmentScrollViewContainer.bounds
//            mask.frame = rect
//            mask.path = path.cgPath
//           self.segmentScrollViewContainer.layer.mask = mask
//
            self.ingredientView.isHidden = false
            self.methodView.isHidden = true
            self.nutrientView.isHidden = true


        }
        
        

        // Do any additional setup after loading the view.
    }
    

    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.recipeImage.image = image
                
            }
        }
    }
    
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        

        switch sender.selectedSegmentIndex {
        case 0:
            self.ingredientView.isHidden = false
            self.methodView.isHidden = true
            self.nutrientView.isHidden = true
 
        case 1:
            self.ingredientView.isHidden = true
            self.methodView.isHidden = false
            self.nutrientView.isHidden = true
        case 2:
            self.ingredientView.isHidden = true
            self.methodView.isHidden = true
            self.nutrientView.isHidden = false
        default:
            self.ingredientView.isHidden = false
            self.methodView.isHidden = true
            self.nutrientView.isHidden = true
        }
        self.segmentScrollViewContainer.bringSubview(toFront: self.views[sender.selectedSegmentIndex])
    }
    
    func set_up_tap_gesture() {
        self.tap_fav_icon_image.addTarget(self, action: #selector(self.tapped_fav_icon_image))
        self.fav_icon_image.addGestureRecognizer(self.tap_fav_icon_image)
        self.fav_icon_image.isUserInteractionEnabled = true;
        if fav_recipe.index(forKey: self.recipe.id) != nil {
            if #available(iOS 13.0, *) {
                self.fav_icon_image.image = UIImage(systemName: "heart.fill")
            }
        }
        
        self.tap_video_player_image.addTarget(self, action: #selector(self.tapped_video_player_image))
        
        self.video_player_image.addGestureRecognizer(self.tap_video_player_image)
        self.video_player_image.isUserInteractionEnabled = true;
        
    }
    
    @objc func tapped_fav_icon_image(){
        let sqlitedb = SqliteDb()
        if fav_recipe.index(forKey: self.recipe.id) == nil {
            RecipeList().addFavouriteRecipe(self.recipe)
            if #available(iOS 13.0, *) {
                self.fav_icon_image.image = UIImage(systemName: "heart.fill")
                sqlitedb.add_recipe(id: self.recipe.id, name: self.recipe.name)
                
                self.viewDidLoad()
                self.viewWillAppear(true)
//                reloadRecipeData()
            }
        }
        else {

            RecipeList().deleteFavRecipe(self.recipe.id)
            sqlitedb.delete_recipe(id: self.recipe.id)
            if #available(iOS 13.0, *) {
                self.fav_icon_image.image = UIImage(systemName: "heart")
                self.viewDidLoad()
                self.viewWillAppear(true)
//                reloadRecipeData()
            }
        }

      }
    
    @objc func tapped_video_player_image(){
        let videoPlayerViewController = VideoPlayerViewController()
        self.navigationController?.pushViewController(videoPlayerViewController, animated: true)
      }


}
