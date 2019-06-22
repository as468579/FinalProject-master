//
//  CatagoryViewController.swift
//  FinalProject
//
//  Created by User18 on 2019/6/21.
//  Copyright © 2019 User02. All rights reserved.
//

import UIKit

class CatagoryViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    var categoryArray: [String] = ["早餐", "午餐", "下午茶", "晚餐", "宵夜", "飲料", "交通", "日常用品", "保險", "網路", "水電瓦斯", "其他"]
    
    @IBOutlet weak var collectionViewControl: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    
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
        
    }
    
    
    // 設定section數量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 設定section內cell數量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.label.text  = categoryArray[indexPath.row]
        cell.label.layer.borderWidth = 1
        cell.label.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ScrollViewController, let index = collectionViewControl.indexPathsForSelectedItems?.first?.item{
            controller.categoryField.text = categoryArray[index]
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
