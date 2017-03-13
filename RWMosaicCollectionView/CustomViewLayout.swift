//
//  CustomViewLayout.swift
//  RWMosaicCollectionView
//
//  Created by Cynthia Strickland on 3/13/17.
//  Copyright © 2017 Fenix Designz. All rights reserved.
//

import UIKit

class CustomViewLayout: UICollectionViewLayout {
  
  var numberOfColumns = 0
  var cache = [UICollectionViewLayoutAttributes]()   //preconfigured attributes will be stored in this variable
  fileprivate var contentHeight: CGFloat = 0        //The following holds h/w dimensions for the layout
  fileprivate let cellHeight: CGFloat = 300.0
  fileprivate var width: CGFloat {
    get {
      return collectionView!.bounds.width
    }
  }
  
  override var collectionViewContentSize : CGSize {
    return CGSize(width: width, height: contentHeight)  //Returns the size of the entire content area using w/h defined earlier
  }
  
  override func prepare() {        //To setup cache of attributes.  We only want to do this once so check to see if it is empty.
    if cache.isEmpty {
      let columnWidth = width / CGFloat(numberOfColumns)    //Calculate Column width - CV width by # of columns
      
      var xOffsets = [CGFloat]()
      for column in 0..<numberOfColumns {
        xOffsets.append(CGFloat(column) * columnWidth)     //Create an ARRAY to hold the width offset for each column
      }
      
      var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)  //Creates ARRAY to hold the height offset for each column
      
      var column = 0                                                    //Step through each frame to determine the offsets, column w/h
      for item in 0..<collectionView!.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
        let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: cellHeight)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)   //Get attributes for current item, assign the calculated frame to the
        attributes.frame = frame                                                    //frame attribute, next add attributes to cache array
        cache.append(attributes)
        
        contentHeight = max(contentHeight, frame.maxY)      //Finally update height, offsets, columns for executing the next loop cycle
        yOffsets[column] = yOffsets[column] + cellHeight
        column = column >= (numberOfColumns - 1) ? 0 : column + 1
      }
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    for attributes in cache {                           //Creates a new array of attributes.  Checks to see if any of the attributes in preconfigured cache are
      if attributes.frame.intersects(rect) {            //visible within the collection view.   If so add the new cache attributes to the new layout attributes
        layoutAttributes.append(attributes)             //array.   Tell CV about new layout class in the main.storyboard CollectionViewFlowLayout.  Finally
      }                                                 //add two lines to MasterViewController.
    }
    return layoutAttributes
  }
  
  
  
  
  
  
  
  
  
  

}
