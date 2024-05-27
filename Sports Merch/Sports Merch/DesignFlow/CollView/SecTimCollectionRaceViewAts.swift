import UIKit

final class SecTimCollectionRaceViewAts: UICollectionView {
    init(cellClass: AnyClass,
         id: String,
         backgroudClr: UIColor,
         scrollDirection: ScrollDirection = .horizontal) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = backgroudClr
        register(cellClass, forCellWithReuseIdentifier: id)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
