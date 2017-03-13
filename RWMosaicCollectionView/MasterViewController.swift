//
//  MasterViewController.swift
//  RWMosaicCollectionView
//
//  Created by Cynthia Strickland on 3/13/17.
//  Copyright © 2017 Fenix Designz. All rights reserved.
//

import UIKit
import AVFoundation

let masterId = "MasterToDetail"
let characterId = "CharacterCell"

class MasterViewController: UICollectionViewController {
    
    let charactersData = Characters.loadCharacters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.isToolbarHidden = true
        collectionView!.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)
        
        let layout = collectionViewLayout as! MosaicViewLayout
        layout.delegate = self
        layout.numberOfColumns = 2
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

extension MasterViewController: MosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        let character = charactersData[indexPath.item]
        let image = UIImage(named: character.name)
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: image!.size, insideRect: boundingRect)
        
        return rect.height
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let character = charactersData[indexPath.item]
        let descriptionHeight = heightForText(character.description, width: width-24)
        let height = 4 + 17 + 4 + descriptionHeight + 12
        return height
    }
    
    func heightForText(_ text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 10)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
    
    
}







