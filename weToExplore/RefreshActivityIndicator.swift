import UIKit

class RefreshActivityIndicator: UIViewController {

    var container: UIView = UIView()    // the container of activity indicator
    var loadingView: UIView = UIView()  // image
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    // start activity indicator
    func startActivityIndicator(_ uiView: UIView) {
        if !activityIndicator.isAnimating {
            container.frame = uiView.frame
            container.center = uiView.center
            container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingView.center = uiView.center
            loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
            loadingView.addSubview(activityIndicator)
            container.addSubview(loadingView)
            uiView.addSubview(container)
//            uiView.addSubview(loadingView)
            activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
            container.removeFromSuperview()
            loadingView.removeFromSuperview()
        }
    }
    
    func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
