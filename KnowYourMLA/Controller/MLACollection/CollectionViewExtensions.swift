//
//  CollectionViewExtensions.swift
//  KnowYourMLA
//
//  Created by Cédric Morier-Roy on 2020-11-25.
//

import Foundation
import UIKit

//MARK: Delegate and Data source
extension MLACollectionVC : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return MLAData.members.count //MARK: adjust
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MLACollectionViewCell

        
        //cell.imageView?.image = #imageLiteral(resourceName: "AppIcon")
        //images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //selecting an item on the collection view will segue to 
        
        //delete it from view controller
//        images.remove(at: indexPath.row)
//
//        //delete a image from collection if tapped
//        collectionView.deleteItems(at: [indexPath])
//
//        //MARK: delete image from CoreData
//        let photo = fetchedResultsController.object(at: indexPath)
//        DataController.shared.viewContext.delete(photo)
//        DataController.shared.saveContext()
//
//        updateFetchResultsController()
    }
}

//MARK: Flow Layout
extension MLACollectionVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return collectionViewInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
      return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding = cellsPerRow * collectionViewInsets.left
        let totalWidth = (view.bounds.width - padding)
        let itemWidth = totalWidth / cellsPerRow
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        return itemSize
  }
}
