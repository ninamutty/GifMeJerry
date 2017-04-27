import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.gifImage = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 30.0, height: 30.0)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var gifImage: UIImageView!
}
