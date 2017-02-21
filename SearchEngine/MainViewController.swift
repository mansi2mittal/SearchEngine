//
//  MainViewController.swift
//  SearchEngine
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

   import UIKit
   import AlamofireImage
   import SwiftyJSON

   class MainViewController: UIViewController {
    
    // MARK: OUTLETS
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelGoogle: UILabel!
    
    @IBOutlet weak var imagesCollectionView:
    UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // CREATING AN ARRAY FOR STORING THE IMAGES FETCHED 
    
    var imagesList = [ImageInfo]()
    
     // MARK: VIEW LIFECYCLE
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
        
    // ASSIGNING THE DATASOURCE AND DELEGATE OF THE COLLECTION VIEW
    
    imagesCollectionView.dataSource = self
    imagesCollectionView.delegate = self
    searchBar.delegate = self
        
    // CREATING THE NIB OF THE CELL OF THE COLLECTION VIEW
        
    let cellNib = UINib( nibName : "CollectionViewCell" , bundle : nil)
        
    // REGISTERING THE NIB OF THE UICOLLECTIONVIEW CELL
        
    imagesCollectionView.register(cellNib, forCellWithReuseIdentifier: "CollectionViewCellID")
        
    // INITIAL LOADING OF DOG PICTURES IN THE COLLECTION VIEW CELL
        
    Webservices().fetchDataFromPixabay(withQuery: "DOGS", success: { (images : [ImageInfo]) in
            
            self.imagesList = images
            self.imagesCollectionView.reloadData()
            
        }) { (error : Error) in
            
        }

        
   // SETTING THE FLOW LAYOUT OF THE COLLECTION VIEW
        
         _ = FlowLayout()
        
        }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
   // KEYBOARD WILL DISAPPEAR WHEN CLICKED ON THE VIEW
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        
    {
        self.view.endEditing(true)
    }
    

   }

  // MARK : EXTENSION OF MAIN VIEW CONTROLLER FOR THE SEARCH BAR

   extension MainViewController : UISearchBarDelegate
    
   {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // ACCESSING THE IMAGES FROM THE WEBSERVICES BY ENTERING THE QUERY
        
        Webservices().fetchDataFromPixabay(withQuery: searchBar.text!, success: { (images : [ImageInfo]) in
            
        self.imagesList = images
        self.imagesCollectionView.reloadData()
            
         }) { (error : Error) in
            
        }
        // DISALLOW EDITING AFTERWARDS
        
        searchBar.endEditing(true)
         }

    
     }

  //  MARK: EXTENSION OF THE MAIN VIEW CONTROLLER FOR THE COLLECTION VIEW

    extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
    
  {

   // RETURNS THE NUMBER OF CELLS IN A PARTICULAR SECTION. HERE THERE IS ONLY ONE SECTION
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesList.count
    }
        
   // RETURNS THE CELL FOR THE PARTICULAR LOCATION IN THE COLLECTION VIEW
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellID", for: indexPath) as? CollectionViewCell
        else {
            
            fatalError(" Cell Not Found") }
        
        if let url = URL(string: imagesList[indexPath.item].previewURL) {
            
            cell.imageInCell.af_setImage(withURL : url)
        }
        
        cell.imageInCell.contentMode = .scaleAspectFill
        
        return cell
        }
        
    // PERFORMING ACTIONS ON THE SELECTED ITEM
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard  let ZoomedView = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewControllerID") as? ImageViewController else {
            fatalError( "Error not found ")}
        
           ZoomedView.imageURL = URL(string : imagesList[indexPath.item].webformatURL)
        
    // TAPPING THE CELL OF THE COLLECTION CELL WILL OPEN THE IMAGE ON FULL SCREEN ON A NEW VIEW CONTROLLER WITH ANIMATION
        
        
       UIView.animate(withDuration: 0.1 , delay: 0.0, options: .curveEaseInOut, animations:
        
           {  self.navigationController?.pushViewController(ZoomedView, animated: true)
                UIView.setAnimationTransition(UIViewAnimationTransition.flipFromRight, for: self.navigationController!.view! , cache: false)
        }, completion:nil )
        
        }
        
}



