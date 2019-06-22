//
//  ScrollViewController.swift
//  FinalProject
//
//  Created by User02 on 2018/12/26.
//  Copyright © 2018 User02. All rights reserved.
//

import UIKit


class ScrollViewController: UIViewController ,UITextFieldDelegate{
    
    struct PropertyKeys{
        static let complete = "complete"
    }
    
    var record: Record?
    var row: Int = 0
    
    // type of record
    var type: String?
    
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var remarksField: UITextView!
    @IBOutlet weak var dpicker: UIDatePicker!
    
    @IBAction func unwindSegueToScroll(seque : UIStoryboardSegue){
        if let source = seque.source as? CatagoryViewController{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
        // initialize text Field
        if let record = record {
            categoryField.text = record.event
            dateField.text = record.time
            costField.text = NSString(format:"%.2f", record.cost) as String
            remarksField.text = record.remarks
        }
        
        dpicker.addTarget(self, action:#selector(self.show_pDate), for: UIControl.Event.valueChanged)
    
        // Do any additional setup after loading the view.
    }

    
    
    // MARK: - Navigation

    @IBAction func show_pDate(_ sender: UIButton) {
        let date = dpicker.date
        print(date)
        let dformattar = DateFormatter()
        dformattar.dateFormat = "yyyy/MM/dd"
        let datestr = dformattar.string(from:date)
        dateField.text = datestr
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // category
        let tmp_event = categoryField.text ?? ""
        
        // date
        let date = dpicker.date
        let dformattar = DateFormatter()
        dformattar.dateFormat = "yyyy/MM/dd"
        let datestr = dformattar.string(from:date)
        
        // cost
        let costValue = ((costField.text ?? "") as NSString).doubleValue
        
        
        // remarks
        let remarks = remarksField.text ?? ""
        
        // remarks
        if let type = type{
            record = Record(time: datestr, event: tmp_event, cost: costValue, remarks: remarks)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var result = true
        if(identifier == PropertyKeys.complete){
            if categoryField.text?.isEmpty == true{
                result = false
                let alertController = UIAlertController(title: "", message: "請輸入事件名稱", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
            else if dateField.text?.isEmpty == true{
                result = false
                let alertController = UIAlertController(title: "", message: "請輸入事件時間", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
            else if costField.text?.isEmpty == true{
                result = false
                let alertController = UIAlertController(title: "", message: "請輸入金額", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
        return result
    }
}
