import UIKit

class CollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var total_time: UILabel!
    

  
    @IBOutlet weak var total_positive: UILabel!
    
    
    @IBOutlet weak var total_negative: UILabel!
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.recipeImage.image = image
                self.recipeImage.layer.cornerRadius = 20
                self.recipeImage.clipsToBounds = true
      

                
            }
        }
    }

    
}
