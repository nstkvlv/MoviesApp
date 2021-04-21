import UIKit.UICollectionView

final class FiltersView: UICollectionReusableView {

    private var collectionView: UICollectionView?
    var filters = [Filter]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .clear
        addSubview(collectionView!)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        collectionView?.register(
            FiletrItemCell.self,
            forCellWithReuseIdentifier: String(describing: FiletrItemCell.self)
        )
    }

}

extension FiltersView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FiletrItemCell.self), for: indexPath) as? FiletrItemCell else { return UICollectionViewCell() }
        cell.setItem(filter: filters[indexPath.item])
        return cell
    }

}

extension FiltersView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = filters[indexPath.item].name.widthOfString() + 20
        return CGSize(width: width, height: 30)
    }

}
