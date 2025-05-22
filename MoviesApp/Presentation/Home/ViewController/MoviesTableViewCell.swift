
import UIKit

class MoviesTableViewCell: UITableViewCell {

    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()

    lazy var watchlistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bookmark")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(watchlistImageView)

        movieImageView.anchor(.leading(leadingAnchor, constant: 8),
                              .top(topAnchor, constant: 8),
                              .width(80),
                              .height(100),
                              .bottom(bottomAnchor, constant: 8))

        watchlistImageView.anchor(.top(topAnchor, constant: 8),
                                  .trailing(trailingAnchor, constant: 12),
                                  .width(24),
                                  .height(24))

        titleLabel.anchor(.top(topAnchor, constant: 8),
                          .leading(movieImageView.trailingAnchor, constant: 12),
                          .trailing(watchlistImageView.leadingAnchor, constant: 8))

        overviewLabel.anchor(.top(titleLabel.bottomAnchor, constant: 4),
                             .leading(titleLabel.leadingAnchor),
                             .trailing(trailingAnchor, constant: 32),
                             .bottom(movieImageView.bottomAnchor))
    }

    func configureCell(movie: Movie) {
        movieImageView.load(from: movie.posterPath ?? "")
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
   //     watchlistImageView.image = movie.isInWatchlist ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
    }

}
