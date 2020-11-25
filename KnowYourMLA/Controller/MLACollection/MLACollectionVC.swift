//
//  MLACollectionVC.swift
//  KnowYourMLA
//
//  Created by Cédric Morier-Roy on 2020-11-25.

import Foundation
import UIKit

class MLACollectionVC : UIViewController
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let collectionViewInsets = UIEdgeInsets(top: 3.0,
                                               left: 3.0,
                                               bottom: 3.0,
                                               right: 3.0)
    let cellsPerRow: CGFloat = 3
    
    //MARK: PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //set map view on PhotoAlbumVC to same region/center as current map
        if let vc = segue.destination as? MLADetailVC
        {
//            if let pinCoord = sender as? CLLocationCoordinate2D
//            {
//                //give the photo album view controller a region centered on the tapped pin
//                let region = MKCoordinateRegion(center: pinCoord, latitudinalMeters: 3000, longitudinalMeters: 3000)
//                vc.region = region
//
//                //get the core data pin object that corresponds to tapped pin (needed to access attached pictures)
//                vc.pin = getPinByLocation(pinCoord.latitude, pinCoord.longitude)
//            }
        }
    }
    
}
