//
//  ImageViewController.swift
//  SearchEngine
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    // OUTLETS
    
    @IBOutlet weak var imageInView: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    // VARIABLE TO HOLD THE URL OF THE IMAGE
    
    var imageURL :URL!
    
    // MARK : VIEW LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // WILL BE CALLED WHENEVER VIEW WILL LAYPUT SUBVIEWS
    
    override func viewWillLayoutSubviews() {
        
        imageInView.af_setImage(withURL: imageURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // HOME SCREEN WILL APPEAR ON THE TAP OF THIS BUTTON
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
    UIView.animate(withDuration: 0.1, animations: {
    UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
    self.navigationController?.popViewController(animated: true)
    UIView.setAnimationTransition(UIViewAnimationTransition.flipFromRight, for: self.navigationController!.view! , cache: false)
        })
    }
   
}
