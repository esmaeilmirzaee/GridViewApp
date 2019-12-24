//
//  ViewController.swift
//  GridViewApp
//
//  Created by Esmaeil MIRZAEE on 23/12/2019.
//  Copyright © 2019 Esmaeil MIRZAEE. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {
  
  
  
  @IBOutlet weak var collectionView: NSCollectionView!
  var flowers = [URL]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
//    print(getFolderPath())
    getFlowerPath()
  }
  
  override var representedObject: Any? {
    didSet {
      // Update the view, if already loaded.
    }
  }
  
  func displayImage(_ indexPath: IndexPath, _ collectionItem: Flowers) {
    let url = flowers[indexPath.item]
    collectionItem.imageView?.image = NSImage(contentsOf: url)
  }
  
  func getFlowerPath() {
    let fileManager = FileManager.default
    let flowerDir = getFolderPath()
    print(flowerDir)
    guard let fileURLs = try? fileManager.contentsOfDirectory(at: flowerDir, includingPropertiesForKeys: nil) else {
      return
    }
    for file in fileURLs {
      if file.pathExtension == "jpg" {
        flowers.append(file)
      }
    }
  }
  
  func getFolderPath() -> URL {
    let fileManager = FileManager.default
    let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    if let documentDir = urls.first {
      
      let flowerDir = documentDir.appendingPathComponent("Flowers")
      
      if !fileManager.fileExists(atPath: flowerDir.path) {
        try? fileManager.createDirectory(at: flowerDir, withIntermediateDirectories: true, attributes: nil)
      }
      return flowerDir
    }
    return URL.init(fileURLWithPath: "")
  }
  
  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return flowers.count
  }
  
  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    let collectionItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("Flowers"), for: indexPath) as! Flowers
    displayImage(indexPath, collectionItem)
    collectionItem.view.wantsLayer = true
    collectionItem.view.layer?.backgroundColor = NSColor.black.cgColor
    return collectionItem
  }
  
}

