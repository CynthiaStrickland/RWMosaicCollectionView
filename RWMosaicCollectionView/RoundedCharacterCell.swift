//
//  RoundedCharacterCell.swift
//  RWMosaicCollectionView
//
//  Created by Cynthia Strickland on 3/13/17.
//  Copyright © 2017 Fenix Designz. All rights reserved.
//

import UIKit

class RoundedCharacterCell: UICollectionViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterTitle: UILabel!
    @IBOutlet weak var characterInfo: UILabel!
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!

  
  var character: Characters? {
    didSet {
      if let theCharacter = character {
        characterImage.image = UIImage(named: theCharacter.name)
        characterTitle.text = theCharacter.title
        characterInfo.text = theCharacter.description
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius = self.frame.size.width * 0.125
    self.layer.borderWidth = 6
    self.layer.borderColor = UIColor(red: 0.5, green: 0.47, blue: 0.25, alpha: 1.0).cgColor
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    characterImage.image = nil
    characterTitle.text = ""
    characterInfo.text = ""
  }
  
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! MosaicLayoutAttributes
        imageViewHeightConstraint.constant = attributes.imageHeight
    }
}
