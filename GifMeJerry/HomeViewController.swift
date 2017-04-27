import UIKit
import SwiftGifOrigin

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


class HomeViewController: UIViewController {
    struct Constant {
        static let gifCellReuseIdentifier = "GifCellReuseIdentifier"
        static let gifCellNibName = "GifCollectionViewCell"
    }
    
    public var gifList = [Gif]()
    let apiConsumer = APIConsumer()
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    //Mark: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nibName = UINib(nibName: Constant.gifCellNibName, bundle:nil)
            collectionView.register(nibName, forCellWithReuseIdentifier: Constant.gifCellReuseIdentifier)
        }
    }
    
    
    //Mark: Lifecycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        apiConsumer.findAllGifs(completion: { gifs in
            self.setGifList(gifs)
        })
    }
    
    //Mark: Custom Functions
    internal func setGifList(_ gifs: [Gif]) {
        self.gifList = gifs
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)

    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.gifCellReuseIdentifier, for: indexPath) as! GifCollectionViewCell
//        guard let gifCollectionViewCell: GifCollectionViewCell = collectionViewCell as? GifCollectionViewCell else {
//            fatalError("GifCollectionViewCell can't be created.")
//        }
        cell.backgroundColor = UIColor.black
        let gifURLString = gifList[indexPath.row].url
        let gifImage = UIImage.gif(url: gifURLString)!
        
        cell.gifImage = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 30.0, height: 30.0)))
        let image = UIImageView(image:#imageLiteral(resourceName: "tiger-mom-cub"))
        cell.gifImage = image
        
        return cell
    }
}


