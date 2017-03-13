//
//  MasterViewController.swift
//  RWMosaicCollectionView
//
//  Created by Cynthia Strickland on 3/13/17.
//  Copyright © 2017 Fenix Designz. All rights reserved.
//

import UIKit

let masterId = "MasterToDetail"
let characterId = "CharacterCell"

class MasterViewController: UICollectionViewController {
  
  let charactersData = Characters.loadCharacters()
      
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController!.isToolbarHidden = true
    let layout = collectionViewLayout as! MosaicViewLayout
    layout.numberOfColumns = 2
    layout.delegate = self    //Add reference to delegate property
    collectionView!.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
    layout.cellPadding = 5
  }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == masterId {
      let detailViewController = segue.destination as! DetailViewController
      detailViewController.character = sender as? Characters
    }
  }
}


extension MasterViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return charactersData.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterId, for: indexPath) as! RoundedCharacterCell
    
    let character = charactersData[indexPath.item]
    cell.character = character 
    
    return cell
  }
}

extension MasterViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let character = charactersData[indexPath.item]
      performSegue(withIdentifier: masterId, sender: character)
  }
}

//MARK:   MOSAIC LAYOUT DELEGATE

extension MasterViewController : MosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random * 100)      //This returns a random height for items .. for now
        
        
    }
}







