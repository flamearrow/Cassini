//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Chen Cen on 10/8/16.
//  Copyright © 2016 Chen Cen. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    struct StoryBoard {
        static let showImageSegue = "Show image"
    }
    
    // note #prepare always creats new MVC, to reuse exsiting ones, use outlet
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == StoryBoard.showImageSegue {
            if let ivc = segue.destination.contentViewController as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageUrl = DemoURL.ImageNamed(imageName: imageName)
                ivc.title = imageName
            }
        }
    }
    
    @IBAction func showDetails(_ sender: UIButton) {
        // splitView might have a bunch of subviews, get the last one
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let imageName = sender.currentTitle
            ivc.imageUrl = DemoURL.ImageNamed(imageName: imageName)
            ivc.title = imageName
        }
        // tell diff btw iphone and ipad, for iphone we need to segue(start a new mvc) each time
        else {
            performSegue(withIdentifier: StoryBoard.showImageSegue, sender: sender)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // this is a field for UIViewcontroller as an extension defined in UISplitViewController
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        // the value returned tells the system has the action is handled or not
        // so we say if we're seeing a splitviewctrl whose master is the extension we defined here and detail is imageview and details image is nil, then don't do the collabpse thing, stay at wehre you are - start screen would start at primary
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController, ivc.imageUrl == nil {
                return true
            }
        }
        return false
    }
}

extension UIViewController {
    // add a var in all UIViewController:
    //  if I can cast myself as NavigationController, i return cast my self
    //  and return visibileViewController(the destination navigation controller is pointing to)
    // note this is a short cut for safty type downcasting as UINavigationController extends UIViewController
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
