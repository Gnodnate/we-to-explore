import UIKit

class RefreshActivityIndicator: UIViewController {

    var container: UIView = UIView()    // the container of activity indicator
    var loadingView: UIView = UIView()  // image
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    // start activity indicator
    func startActivityIndicator(uiView: UIView) {
        if !activityIndicator.isAnimating() {
//            container.frame = uiView.frame
//            container.center = uiView.center
//            container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
            loadingView.frame = CGRectMake(0, 0, 80, 80)
            loadingView.center = uiView.center
            loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
            activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 2);
            loadingView.addSubview(activityIndicator)
//            container.addSubview(loadingView)
//            uiView.addSubview(container)
            uiView.addSubview(loadingView)
            activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        if activityIndicator.isAnimating() {
            activityIndicator.stopAnimating()
//            container.removeFromSuperview()
            loadingView.removeFromSuperview()
        }
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
