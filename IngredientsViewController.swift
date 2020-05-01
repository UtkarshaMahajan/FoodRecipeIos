import UIKit

class IngredientsViewController: UIViewController {
    
    
    var recipe: Recipe!
    var ingredients_string : String = ""
    private let ingredientListTextView:UITextView = {
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
        view.addSubview(ingredientListTextView)
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9663686226, blue: 0.9621092037, alpha: 1)

        updateUI()
        setUpAutoLayout()


        // Do any additional setup after loading the view.
    }
    func setUpAutoLayout() {
            ingredientListTextView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
           ingredientListTextView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
           ingredientListTextView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
           ingredientListTextView.heightAnchor.constraint(equalToConstant: view.frame.height - 10).isActive = true
//           ingredientListTextView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
           
       }
    func updateUI() {
        let bullet = "•  "
        
        var strings = recipe.ingredients

        
        var updated_strings = [String]()

        var count = 1
        for str  in strings {
            updated_strings.append("\(bullet)\(str)")
            count += 1
        }
        var attributes = [NSAttributedStringKey: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .title1)
        attributes[.foregroundColor] = UIColor.darkGray


        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = updated_strings.joined(separator: "\n")
        ingredientListTextView.text = NSAttributedString(string: string, attributes: attributes).string
        ingredientListTextView.textAlignment = .justified
        ingredientListTextView.isEditable = false
        ingredientListTextView.font = UIFont(name:"Chalkboard SE",size:16)
        ingredientListTextView.textColor = #colorLiteral(red: 0.5799615383, green: 0.5800500512, blue: 0.5799494386, alpha: 1)
        ingredientListTextView.isScrollEnabled = true
        ingredientListTextView.isUserInteractionEnabled = true
        ingredientListTextView.showsVerticalScrollIndicator = true
         ingredientListTextView.showsHorizontalScrollIndicator = true
        ingredientListTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    }

}
