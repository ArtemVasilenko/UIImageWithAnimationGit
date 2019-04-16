import UIKit
import WebKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myImageVIew: UIImageView!
    @IBOutlet weak var myWebKit: WKWebView!
    
    let url = Bundle.main.url(forResource: "spider", withExtension: "gif")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myWebKit.layer.borderWidth = 2
        myWebKit.layer.borderColor = UIColor.blue.cgColor
        myWebKit.layer.cornerRadius = 10
        myWebKit.contentMode = .scaleAspectFill
        
        print(url?.path ?? "error get url")
        myWebKit.load(URLRequest(url: url!))
        
        let frameImageView = myImageVIew.frame
        print(frameImageView)
        
        guard let newImageView = UIImageView.fromGif(frame: frameImageView, resourceName: "spider") else {
            return
        }
        
        view.addSubview(newImageView)
        
//        myImageVIew = UIImageView.fromGif(frame: frameImageView, resourceName: "spider")
        
        newImageView.startAnimating()
        
    }
}

extension UIImageView {
    
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("not exist gif")
            return nil
        }
        
        let url = URL(fileURLWithPath: path)
        
        guard let gifData = try? Data(contentsOf: url),
            let source = CGImageSourceCreateWithData(gifData as CFData, nil)
            else {
                return nil
        }
        
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        print("images count = \(imageCount)")
        
        for i in 0..<imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        
        let gifImageVIew = UIImageView(frame: frame)
        
        gifImageVIew.animationImages = images
        
        return gifImageVIew
        
    }
    
}

