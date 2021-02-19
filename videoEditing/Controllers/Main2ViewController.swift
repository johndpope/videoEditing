//
//  Main2ViewController.swift
//  e-g
//
//  Created by macbook on 7/1/20.
//  Copyright © 2020 macbook. All rights reserved.
//
import UIKit
import AVFoundation
import MOLH
class Main2ViewController: UIViewController {
    var objectss:[MainCategory]=[]
  
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
              setUpData()
        setCellSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension Main2ViewController{
    
   public func setUpData(){
    
    
    
    objectss.append(MainCategory.snapShat)
    objectss.append(MainCategory.whatsapp)
    objectss.append(MainCategory.messenger)
    objectss.append(MainCategory.instagram)
    objectss.append(MainCategory.youTube)
    objectss.append(MainCategory.tikTok)

 
    
        
    }
    
}
extension Main2ViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return objectss.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        var cell:CollectionCategoryViewCells=collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCategoryViewCells", for: indexPath) as! CollectionCategoryViewCells
        let objj=self.objectss[indexPath.row]
        cell.obj = objj
        cell.configure()
      return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CutterViewController") as! CutterViewController
        vc.objects = self.objectss[indexPath.row]
        navigationController?.isNavigationBarHidden = true

   navigationController?.pushViewController(vc, animated: true)
//     self.show(vc, sender: nil)
        if let cell = collectionView.cellForItem(at: indexPath)
           {
            var newFrame = CGAffineTransform(scaleX: 0.9, y: 0.9)
               cell.transform = newFrame

            UIView.animate(withDuration:0.2, animations: { () -> Void in
                cell.transform = CGAffineTransform.identity
                   
                   collectionView.collectionViewLayout.invalidateLayout()
                   }, completion: { (finished) -> Void in
                 collectionView.collectionViewLayout.invalidateLayout()
               })
           }
        
        
        
        
        
      animateOfView()
    }
    public func animateOfView(){
        
          let someView = UIView()
          let scaleTransform = CGAffineTransform(scaleX:1.2, y: 1.2)
          someView.transform = scaleTransform

          UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseIn, animations: {
              someView.transform = CGAffineTransform.identity
          })
      }

    private func setCellSize(){
        let layout = UICollectionViewFlowLayout()
       layout.minimumInteritemSpacing = 8
       layout.minimumLineSpacing = 18
        layout.invalidateLayout()
        let width:CGFloat=(UIScreen.main.bounds.size.width - (58))/2
       let height:CGFloat = (474/510)*width
       // let height:CGFloat=(UIScreen.main.bounds.size.height - (380))/3
        layout.itemSize = CGSize(width: width, height: height)
        collectionView.setCollectionViewLayout(layout, animated: true, completion: nil)
    }
}
