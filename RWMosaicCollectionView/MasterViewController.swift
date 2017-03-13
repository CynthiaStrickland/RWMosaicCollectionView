//
//  MasterViewController.swift
//  RWMosaicCollectionView
//
//  Created by Cynthia Strickland on 3/13/17.
//  Copyright © 2017 Fenix Designz. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {
  
  let charactersData = Characters.loadCharacters()
      
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController!.isToolbarHidden = true
    let layout = collectionViewLayout as! CustomViewLayout
    layout.numberOfColumns = 2
  }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "MasterToDetail" {
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! RoundedCharacterCell
    
    let character = charactersData[indexPath.item]
    cell.character = character 
    
    return cell
  }
}

extension MasterViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let character = charactersData[indexPath.item]
      performSegue(withIdentifier: "MasterToDetail", sender: character)
  }
}







