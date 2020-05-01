

import UIKit

class NutrientViewController: UIViewController {

    var recipe: Recipe!
    var nutrient_string : String = ""
    private let  nutrientListTextView:UITextView = {
    let view = UITextView()
        view.backgroundColor = .clear
        view.isOpaque = false
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
    }()
    
    init(_ recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview( nutrientListTextView)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9663686226, blue: 0.9621092037, alpha: 1)
        updateUI()
        setUpAutoLayout()

        // Do any additional setup after loading the view.
    }
    func setUpAutoLayout() {
            nutrientListTextView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            nutrientListTextView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
           nutrientListTextView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
            nutrientListTextView.heightAnchor.constraint(equalToConstant: view.frame.height - 10).isActive = true
//           ingredientListTextView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
           
       }
    func updateUI() {
        let bullet = "•  "
        var strings = recipe.nutrition
        
        var updated_strings = [String]()
//        strings = strings.map {
//
//            return bullet + $0
//
//        }
        var count = 1
        for (nutrient, value)  in strings {
            updated_strings.append(" \(bullet)\(nutrient) : \(value)")
            count += 1
        }
        var attributes = [NSAttributedStringKey: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .title1)
        attributes[.foregroundColor] = UIColor.darkGray


        let paragraphStyle = NSMutableParagraphStyle()
        attributes[.paragraphStyle] = paragraphStyle

        let string = updated_strings.joined(separator: "\n")
        nutrientListTextView.text = NSAttributedString(string: string, attributes: attributes).string
         nutrientListTextView.textAlignment = .left
         nutrientListTextView.isEditable = false
        nutrientListTextView.font = UIFont(name:"Chalkboard SE",size:16)
         nutrientListTextView.textColor = #colorLiteral(red: 0.5799615383, green: 0.5800500512, blue: 0.5799494386, alpha: 1)
         nutrientListTextView.isScrollEnabled = true
        nutrientListTextView.isUserInteractionEnabled = true
        nutrientListTextView.showsVerticalScrollIndicator = true
         nutrientListTextView.showsHorizontalScrollIndicator = true
        nutrientListTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    }

}


