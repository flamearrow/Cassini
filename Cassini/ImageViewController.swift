//
//  ImageViewController.swift
//  Cassini
//
//  Created by Chen Cen on 10/2/16.
//  Copyright © 2016 Chen Cen. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    var imageUrl: NSURL? {
        didSet {
            image = nil
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
        }
    }

    private func fetchImage() {
        // nil check
        if let url = imageUrl {
            // fetch and set
            if let imageData = NSData(contentsOf: url as URL) {
                image = UIImage(data: imageData as Data)
            }
        }
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            // by this time scrollView might not be initialized yet
            // it's only scrollable after we set its size 
            scrollView?.contentSize = imageView.frame.size
        }
        get {
            return imageView.image
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // note we declared this controller contains a scrollView, so instead of using 
        // the default view, we can use this
        scrollView.addSubview(imageView)
        imageUrl = NSURL(string: DemoURL.Bird)
    }
}
