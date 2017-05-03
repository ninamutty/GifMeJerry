import UIKit

class GifCollectionViewCell: UICollectionViewCell {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    @IBOutlet weak var gifImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.gifImage = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 30.0, height: 30.0)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(image: UIImage) {
        self.gifImage.image = image
    }
    
}
