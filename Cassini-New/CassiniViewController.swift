//
//  CassiniViewController.swift
//  Cassini-New
//
//  Created by Orest Hazda on 29/10/16.
//  Copyright © 2016 Orest Hazda. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitViewController?.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController, ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func showImage(_ sender: AnyObject) {
        
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let imageName = sender.currentTitle
            ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName!)
            ivc.title = imageName!
        } else {
            performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender)
        }
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = (segue.destination.contentViewController as? ImageViewController) {
                
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                ivc.title = imageName
                
            }
        }
    }

}


extension UIViewController {

    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }else {
            return self
        }
    }

}
