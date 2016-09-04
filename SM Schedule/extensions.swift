

import UIKit
let imageCache = NSCache()
extension UIImageView {
    func loadImageUsingCache(urlString: String){
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage{
            self.image = cachedImage
            return
        }
        let profilePicUrl = urlString
        let url = NSURL(string: profilePicUrl)
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                if let dowloadedImage = UIImage(data: data!){
                    imageCache.setObject(dowloadedImage, forKey: urlString)
                    self.image = dowloadedImage
                }
                
            })
            
        }).resume()
        
        
    }
}