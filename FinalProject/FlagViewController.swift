//
//  FlagViewController.swift
//  FinalProject
//
//  Created by User18 on 2019/6/20.
//  Copyright © 2019 User02. All rights reserved.
//

import UIKit

class FlagViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionViewControl: UICollectionView!
    
    var currentFlag: String?
    var flagArray: [String] = ["USA", "Canada", "China", "Germany", "Italy", "Taiwan", "UnitedKingdom", "Japon", "Korea", "Samoa", "Uruguay", "Mexico", "Guatemala", "Libya"]
    
    // 取得手機螢幕大小
    let fullScreenSize = UIScreen.main.bounds.size
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
        // 設定上下左右的間距
        collectionLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        // 設置cell的大小
        let w  = fullScreenSize.width
        // collectionLayout.itemSize = CGSize(width: w/2-10, height: 100)
        
        // 設置cell與cell之間的間距
        collectionLayout.minimumLineSpacing = 5
        
        // 設定為上下捲動
        collectionLayout.scrollDirection = .vertical
        
        // 設定header尺寸
        collectionLayout.headerReferenceSize =
            CGSize(width: w, height: 40)
        
        // Do any additional setup after loading the view.
    }
    
    // 設定section數量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 設定section內cell數量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flagCell", for: indexPath) as! FlagCollectionViewCell
        cell.imageView.image = UIImage(named: flagArray[indexPath.row])
        cell.imageView.layer.borderWidth = 1
        cell.imageView.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? MenuViewController, let index = collectionViewControl.indexPathsForSelectedItems?.first?.item{
            let image = UIImage(named: flagArray[index])
            if let flagType = currentFlag{
                if flagType == "source"{

                    controller.sourceFlag = flagArray[index]
                }
                else if flagType == "dest"{
                    controller.destFlag = flagArray[index]
                }
            }
        }
        
        if let controller = segue.destination as? RecordViewController, let index = collectionViewControl.indexPathsForSelectedItems?.first?.item{
            let image = UIImage(named: flagArray[index])
            if let flagType = currentFlag{
                if flagType == "source"{
                    controller.sourceFlag = flagArray[index]
                }
                else if flagType == "dest"{
                    controller.destFlag = flagArray[index]
                }
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
