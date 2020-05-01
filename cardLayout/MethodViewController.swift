
import UIKit

class MethodViewController: UIViewController {
    
    var recipe: Recipe!
    var instructions_string : String = ""
    private let instructionsListTextView:UITextView = {
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
        view.addSubview(instructionsListTextView)
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9663686226, blue: 0.9621092037, alpha: 1)
        updateUI()
        setUpAutoLayout()

        // Do any additional setup after loading the view.
    }
    func setUpAutoLayout() {
            instructionsListTextView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
           instructionsListTextView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
           instructionsListTextView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
           instructionsListTextView.heightAnchor.constraint(equalToConstant: view.frame.height - 10).isActive = true
//           ingredientListTextView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
           
       }
    func updateUI() {
        
        var strings = recipe.instruction
        
        var updated_strings = [String]()

        var count = 1
        for str  in strings {
            updated_strings.append("\(count). \(str)")
            count += 1
        }
        var attributes = [NSAttributedStringKey: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .title1)
        attributes[.foregroundColor] = UIColor.darkGray


        let paragraphStyle = NSMutableParagraphStyle()
        attributes[.paragraphStyle] = paragraphStyle

        let string = updated_strings.joined(separator: "\n\n")
       instructionsListTextView.text = NSAttributedString(string: string, attributes: attributes).string
        instructionsListTextView.textAlignment = .justified
        instructionsListTextView.isEditable = false
       instructionsListTextView.font = UIFont(name:"Chalkboard SE",size:16)
        instructionsListTextView.textColor = #colorLiteral(red: 0.5799615383, green: 0.5800500512, blue: 0.5799494386, alpha: 1)
        instructionsListTextView.isScrollEnabled = true
       instructionsListTextView.isUserInteractionEnabled = true
        instructionsListTextView.showsVerticalScrollIndicator = true
        instructionsListTextView.showsHorizontalScrollIndicator = true
        instructionsListTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        

    }

}
