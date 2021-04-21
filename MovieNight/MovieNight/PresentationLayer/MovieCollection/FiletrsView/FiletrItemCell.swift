import UIKit.UICollectionViewCell

final class FiletrItemCell: UICollectionViewCell {

    private let filterLabel = UILabel()

    func setItem(filter: Filter) {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = filter.color.cgColor

        filterLabel.text = filter.name
        filterLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        filterLabel.textColor = .black
        filterLabel.textAlignment = .center

        addSubview(filterLabel)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        filterLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        filterLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        filterLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
