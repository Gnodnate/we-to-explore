//
//  WEContainerViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/21/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WEContainerViewController: UIViewController, UIGestureRecognizerDelegate {
    lazy var centerViewController:WETopicListTableViewController =
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopListTableViewController") as! WETopicListTableViewController
    
    lazy var leftViewController:WENodeListTableViewController =
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NodeListTable") as! WENodeListTableViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(leftViewController.view)
        leftViewController.view.tag = 2
//        leftViewController.view.snp_makeConstraints { (make) in
//            make.leading.top.bottom.equalTo(self.view)
//            make.width.equalTo(screenWidth/2)
//        }
        leftViewController.view.frame = self.view.bounds
        
        self.view.addSubview(centerViewController.view)
        centerViewController.view.tag = 1
        //        centerViewController.view.snp_makeConstraints { (make) in
        //            make.edges.equalTo(self.view)
        //        }
        centerViewController.view.frame = self.view.bounds

        
        self.view.bringSubview(toFront: centerViewController.view)
        
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipeGestureRight.direction = .right
        centerViewController.view.addGestureRecognizer(swipeGestureRight)
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipeGestureRight.direction = .left
        centerViewController.view.addGestureRecognizer(swipeGestureLeft)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - SwipeGestureRecognizer
    @IBAction func swipeGesture(_ recognizer:UISwipeGestureRecognizer) {
        let layer = centerViewController.view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 20.0
        
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.right:
            leftViewController.view.isHidden = false
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(.easeIn)
            if centerViewController.view.frame.origin.x == self.view.frame.origin.x
            || centerViewController.view.frame.origin.x == -100{
                centerViewController.view.frame.origin.x += 100
            }
            UIView.commitAnimations()
        case UISwipeGestureRecognizerDirection.left:
            leftViewController.view.isHidden = false
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(.easeIn)
            if centerViewController.view.frame.origin.x == self.view.frame.origin.x
                || centerViewController.view.frame.origin.x == 100{
                centerViewController.view.frame.origin.x -= 100
            }
//            leftViewController.view.hidden = true
            UIView.commitAnimations()
        default:
            print("Unrecoginze swipe")
        }
    }
    
    internal func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("\(gestureRecognizer.view)")
        return true
    }
}
