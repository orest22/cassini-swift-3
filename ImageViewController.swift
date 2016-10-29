//
//  ImageViewController.swift
//  Cassini-New
//
//  Created by Orest Hazda on 29/10/16.
//  Copyright © 2016 Orest Hazda. All rights reserved.
//

import UIKit

var counter = 0

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: NSURL? {
        didSet {
            image = nil
            if view.window != nil {
              fetchImage()
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.maximumZoomScale = 1.0
            scrollView.minimumZoomScale = 0.03
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                let contentOfUrl = NSData(contentsOf: url as URL)
                
                DispatchQueue.main.async { [weak self] in
                    
                    //Checks if url is still the one we want
                    if url == self?.imageURL {
                    
                        if let imageData = contentOfUrl {
                            self?.image = UIImage(data: imageData as Data)
                        } else {
                            self?.spinner?.stopAnimating()
                        }
                    }
                }
                
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if image == nil {
            fetchImage()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        counter += 1

        // Do any additional setup after loading the view.
        
        scrollView.addSubview(imageView)
        //imageURL = NSURL(string: DemoURL.Stanford);
        print("ImageViewController instance count: \(counter)")
    }
    
    deinit {
         counter -= 1
    }


}
