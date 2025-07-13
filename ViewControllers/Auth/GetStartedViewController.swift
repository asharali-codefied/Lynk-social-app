
import UIKit

class GetStartedViewController: UIViewController{
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"bg"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView;
    }();
    
    private let logoImageView: UIImageView = {
        guard let logo = UIImage(named: "logo-white") else {
            fatalError("Image 'logo-white' not found in assets.")
        }
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let subtitle : UILabel = {
        let subtitle = UILabel();
        subtitle.textColor = .white;
        subtitle.numberOfLines = 0;
        subtitle.font = UIFont.systemFont(ofSize: 20, weight: .light)
        subtitle.text = "Continue to signup for free, if you already have an account, we'll log you in.";
        
        return subtitle;
    }();
    private let introTitle : UILabel = {
        let text = UILabel();
        text.textColor = .white;
        text.text = "Navigating\nThe Landscape Of Design."
        text.font = UIFont.systemFont(ofSize: 50, weight: .bold);
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        text.translatesAutoresizingMaskIntoConstraints = false;
        return text;
    }();
    
    let getStartedButton: UIButton = {
        let btn = UIButton(type: .system)

        var config = UIButton.Configuration.filled()
        config.title = "Get Started"
        config.image = UIImage(systemName: "arrow.up.right")
        config.imagePadding = 8
        config.background.cornerRadius = 25
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        
        let titleFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        config.attributedTitle = AttributedString("Get Started", attributes: AttributeContainer([.font: titleFont]))
        btn.configuration = config
        btn.semanticContentAttribute = .forceRightToLeft
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }();
    func createSocialButton(image: UIImage?, target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)

        var config = UIButton.Configuration.plain()
        config.image = image
        config.imagePadding = 0
        config.imagePlacement = .top
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule

        button.configuration = config
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor;
        button.layer.cornerRadius = 25;
        button.clipsToBounds = true;
        button.addTarget(target, action: action, for: .touchUpInside)

        return button
    }
    
    lazy var appleButton = createSocialButton(
    image: UIImage(named: "google-30"),
    target:self,
    action: #selector(handleGoogleAuth),
    )
    lazy var googleButton = createSocialButton(
    image: UIImage(systemName: "apple.logo"),
    target:self,
    action: #selector(handleAppleAuth),
    )
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [getStartedButton, appleButton, googleButton])
        stack.axis = .horizontal;
        stack.distribution = .fillProportionally;
        stack.spacing = 16;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        return stack;
    }()
        
    @objc private func handleAppleAuth(){
   print("apple button clicked")
  }
    
    @objc private func handleGoogleAuth(){
   print("google button clicked")
  }
    lazy var socialStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [appleButton, googleButton])
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()

    lazy var buttonRow: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [getStartedButton, socialStack])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [introTitle, subtitle])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()

    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStack, buttonRow])
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    
    private func setupLayout(){
        view.addSubview(logoImageView);
        view.addSubview(backgroundImageView);
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

                logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                logoImageView.widthAnchor.constraint(equalToConstant: 40),
                logoImageView.heightAnchor.constraint(equalToConstant: 40),

                // Social buttons fixed
                appleButton.widthAnchor.constraint(equalToConstant: 50),
                appleButton.heightAnchor.constraint(equalToConstant: 50),
                googleButton.widthAnchor.constraint(equalToConstant: 50),
                googleButton.heightAnchor.constraint(equalToConstant: 50),

                // Make getStartedButton flexible
                getStartedButton.heightAnchor.constraint(equalToConstant: 50),
                
                // Main vertical stack pinned to bottom
                mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            ])
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        setupLayout();
    }
}
