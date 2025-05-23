
import UIKit

class CastCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 37
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        setupLayOut()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayOut() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        imageView.anchor(.top(contentView.topAnchor, constant: 8),
                         .leading(contentView.leadingAnchor, constant: 8),
                         .trailing(contentView.trailingAnchor, constant: 8))

        nameLabel.anchor(.leading(contentView.leadingAnchor, constant: 4),
                         .trailing(contentView.trailingAnchor, constant: 4),
                         .top(imageView.bottomAnchor, constant: 8),
                         .height(40),
                         .bottom(contentView.bottomAnchor, constant: 8))

    }

    func configure(name: String, image: String?) {
        nameLabel.text = name
        imageView.load(from: image ?? "")
    }

}

