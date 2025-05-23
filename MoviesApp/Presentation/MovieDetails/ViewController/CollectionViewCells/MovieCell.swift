
import UIKit

class MovieCell: UICollectionViewCell {

    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
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
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)

        posterImageView.anchor(.top(contentView.topAnchor, constant: 8),
                               .leading(contentView.leadingAnchor, constant: 8),
                               .trailing(contentView.trailingAnchor, constant: 8))

        titleLabel.anchor(.top(posterImageView.bottomAnchor, constant: 8),
                          .leading(contentView.leadingAnchor, constant: 4),
                          .trailing(contentView.trailingAnchor, constant: 4),
                          .height(40),
                          .bottom(contentView.bottomAnchor, constant: 8))
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        posterImageView.load(from: movie.posterPath ?? "")
    }

}

