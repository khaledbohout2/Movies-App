
import UIKit

extension MovieDetailsVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.actorsOfSimilarMoviesCV {
            return viewModel.castsOfSimilarMovies.actors.count
        } else if collectionView == mainView.directorsOfSimilarMoviesCV {
            return viewModel.castsOfSimilarMovies.directors.count
        } else if collectionView == mainView.similarMoviesCV {
            return viewModel.similarMovies.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.actorsOfSimilarMoviesCV {
            let cell: CastCell = collectionView.forceDequeueCell(identifier: CastCell.identifier, for: indexPath)

            let actor = viewModel.castsOfSimilarMovies.actors[indexPath.item]
            cell.configure(name: actor.name, image: actor.profilePath)

            return cell
        } else if collectionView == mainView.directorsOfSimilarMoviesCV {
            let cell: CastCell = collectionView.forceDequeueCell(identifier: CastCell.identifier, for: indexPath)
            let director = viewModel.castsOfSimilarMovies.directors[indexPath.item]
            cell.configure(name: director.name, image: director.profilePath)
            
            return cell
        } else if collectionView == mainView.similarMoviesCV {
            let cell: MovieCell = collectionView.forceDequeueCell(identifier: MovieCell.identifier, for: indexPath)

            let movie = viewModel.similarMovies[indexPath.item]
            cell.configure(with: movie)

            return cell
        }

        return UICollectionViewCell()
    }

}

extension MovieDetailsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == mainView.actorsOfSimilarMoviesCV || collectionView == mainView.directorsOfSimilarMoviesCV {
            return CGSize(width: 90, height: 136)
        } else if collectionView == mainView.similarMoviesCV {
            return CGSize(width: 194, height: 250)
        }
        return .zero
    }

}

