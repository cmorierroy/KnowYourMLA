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
        return MLAData.members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mlaCell", for: indexPath) as! MLACollectionViewCell

        let member = MLAData.members[indexPath.row]
        
        cell.image?.image = member.image
        cell.image?.layer.cornerRadius = 50
        cell.image?.layer.borderWidth = 10
        cell.image?.layer.borderColor = MLAData.colorOfParty(party: member.party)
        //cell.backgroundView
        cell.nameLabel?.text = member.name
        cell.constituencyLabel?.text = member.constituency
        cell.partyLabel?.text = member.party
        
        if(cell.isSelected)
        {
            //create white highlight to indicate selection
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        }
        else
        {
            cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        }
        cell.layer.cornerRadius = 20
        //cell.layer.borderColor = UIColor()
        //cell.backgroundColor = MLAData.colorOfParty(party: member.party)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //reload to show highlight
        collectionView.reloadItems(at: [indexPath])
        
        //segue to MLADetailVC
        performSegue(withIdentifier: "toMLADetailVC", sender: nil)
        
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
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets
//    {
//        return collectionViewInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
//    {
//      return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
//    {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        let padding = cellsPerRow * collectionViewInsets.left
//        let totalWidth = (view.bounds.width - padding)
//        let itemWidth = totalWidth / cellsPerRow
//        let itemSize = CGSize(width: itemWidth, height: itemWidth)
//
//        return itemSize
//  }
}
