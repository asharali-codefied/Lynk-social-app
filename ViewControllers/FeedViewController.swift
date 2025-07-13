import UIKit

class FeedViewController: BaseViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Lynk"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    override func setupViews() {
        super.setupViews()
        view.addSubview(titleLabel)
    }

    override func setupLayout() {
        super.setupLayout()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
