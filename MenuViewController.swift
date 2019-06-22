//
//  MenuViewController.swift
//  FinalProject
//
//  Created by User18 on 2019/6/20.
//  Copyright © 2019 User02. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var sourceFlag:String?
    var destFlag:String?
    var sourceExRate: Double?
    var destExRage: Double?
    var backgroundImage: UIImage?
    
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var sourceFlagBtn: UIButton!
    @IBOutlet weak var destFlagBtn: UIButton!
    @IBOutlet weak var ExRateField: UITextField!
    
    // 註冊Unwind segue
    @IBAction func unwindSegueToShowFlag(segue : UIStoryboardSegue){
        
        if let source = segue.source as? FlagViewController{
            if let sourceFlag = sourceFlag, let destFlag = destFlag{
                sourceFlagBtn.setImage(UIImage(named: sourceFlag), for: .normal)
                destFlagBtn.setImage(UIImage(named: destFlag), for: .normal)
            }
            getExRate()
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set imagePicker delegate
        self.imagePicker.delegate = self
        
        // set background
        backgroundImage = UIImage(named:"bg")
        self.view.backgroundColor = UIColor(patternImage: backgroundImage!)
        
        // set Button border
        sourceFlagBtn.layer.borderWidth = 2
        sourceFlagBtn.layer.borderColor = UIColor.black.cgColor
        destFlagBtn.layer.borderWidth = 2
        destFlagBtn.layer.borderColor = UIColor.black.cgColor
        
        // initialize flag
        sourceFlag = "Taiwan"
        destFlag = "USA"
        sourceFlagBtn.setImage(UIImage(named: sourceFlag!), for: .normal)
        destFlagBtn.setImage(UIImage(named: destFlag!), for: .normal)
        
        // get Exchange Rate
        getExRate()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setBackground(_ sender: UIButton) {
        let controller = UIAlertController(title: "設定背景", message: "", preferredStyle: .actionSheet)
        
        let choices = ["Take Photo", "Choose Photo"]
        /*
        for choice in choices{
            let action = UIAlertAction(title: choice, style: .default, handler: nil)
            controller.addAction(action)
        }
         */
        
        let action1 = UIAlertAction(title: choices[0], style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        controller.addAction(action1)
        
        let action2 = UIAlertAction(title: choices[1], style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        controller.addAction(action2)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
    }
    func getExRate(){
        if let urlStr = "https://tw.rter.info/capi.php".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data, let globalTradeInfo = try? decoder.decode(tradeInfo.self, from: data) {
                    let info = tradeInfo(
                                    USDCAD: globalTradeInfo.USDCAD, // Cananda
                                    USDCNY: globalTradeInfo.USDCNY, // China
                                    USDDEM: globalTradeInfo.USDDEM, // Germany
                                    USDITL: globalTradeInfo.USDITL, // Italy
                                    USDTWD: globalTradeInfo.USDTWD, // Taiwab
                                    USDGBP: globalTradeInfo.USDGBP, // UnitesKingdom
                                    USDJPY: globalTradeInfo.USDJPY, // Japon
                                    USDKRW: globalTradeInfo.USDKRW, // Korea
                                    USDWST: globalTradeInfo.USDWST, // Samoa
                                    USDUYU: globalTradeInfo.USDUYU, // Uruguay
                                    USDMXV: globalTradeInfo.USDMXV, // Mexico
                                    USDGTQ: globalTradeInfo.USDGTQ, // Guatemala
                                    USDLYD: globalTradeInfo.USDLYD  // Libya
                                )
                    DispatchQueue.main.async {
                        
                        var srcExrRate = 0.0
                        var destExRate = 0.0
                        
                        if let src = self.sourceFlag{
                            switch src{
                            case "USA":
                                srcExrRate = 1.0
                                break
                            case "Canada":
                                srcExrRate = info.USDCAD.Exrate
                                break
                            case "China":
                                srcExrRate = info.USDCNY.Exrate
                                break
                            case "Germany":
                                srcExrRate = info.USDDEM.Exrate
                                break
                            case "Italy":
                                srcExrRate = info.USDITL.Exrate
                                break
                            case "Taiwan":
                                srcExrRate = info.USDTWD.Exrate
                                break
                            case "UnitedKingdom":
                                srcExrRate = info.USDGBP.Exrate
                                break
                            case "Japon":
                                srcExrRate = info.USDJPY.Exrate
                                break
                            case "Korea":
                                srcExrRate = info.USDKRW.Exrate
                                break
                            case "Samoa":
                                srcExrRate = info.USDWST.Exrate
                                break
                            case "Uruguay":
                                srcExrRate = info.USDUYU.Exrate
                                break
                            case "Mexico":
                                srcExrRate = info.USDMXV.Exrate
                                break
                            case "Guatemala":
                                srcExrRate = info.USDGTQ.Exrate
                                break
                            case "Libya":
                                srcExrRate = info.USDLYD.Exrate
                                break
                            default:
                                break
                            }
                        }
                        if let dest = self.destFlag{
                            switch dest{
                            case "USA":
                                destExRate = 1.0
                                break
                            case "Canada":
                                destExRate = info.USDCAD.Exrate
                                break
                            case "China":
                                destExRate = info.USDCNY.Exrate
                                break
                            case "Germany":
                                destExRate = info.USDDEM.Exrate
                                break
                            case "Italy":
                                destExRate = info.USDITL.Exrate
                                break
                            case "Taiwan":
                                destExRate = info.USDTWD.Exrate
                                break
                            case "UnitedKingdom":
                                destExRate = info.USDGBP.Exrate
                                break
                            case "Japon":
                                destExRate = info.USDJPY.Exrate
                                break
                            case "Korea":
                                destExRate = info.USDKRW.Exrate
                                break
                            case "Samoa":
                                destExRate = info.USDWST.Exrate
                                break
                            case "Uruguay":
                                destExRate = info.USDUYU.Exrate
                                break
                            case "Mexico":
                                destExRate = info.USDMXV.Exrate
                                break
                            case "Guatemala":
                                destExRate = info.USDGTQ.Exrate
                                break
                            case "Libya":
                                destExRate = info.USDLYD.Exrate
                                break
                            default:
                                break
                            }
                        }
                        self.ExRateField.text = String(format: "%.2f", destExRate / srcExrRate)
                    }
                    
                }
            }
            task.resume()
        }
    }
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {

        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 取得照片
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        // 設定背景
        self.view.backgroundColor = UIColor(patternImage: image)
        
        // dismiss controller
        picker.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? FlagViewController, let button = sender as? UIButton{
            if button.tag == 0{
                controller.currentFlag = "source"
            }
            else if button.tag == 1{
                controller.currentFlag = "dest"
            }
        }
        
        if let controller = segue.destination as? RecordViewController,
            let sourceFlag = sourceFlag,
            let destFlag = destFlag,
            let button = sender as? UIButton
        {
            controller.sourceFlag = sourceFlag
            controller.destFlag = destFlag
            if button.tag == 2 {
                controller.type = "income"
            }
            else if button.tag == 3{
                controller.type = "expense"
            }
            
        }
        
        if  let controller = segue.destination as? BalanceViewController,
            let incomes = Record.read(key: "income"),
            let expenses = Record.read(key: "expense")
        {
            controller.incomes = incomes
            controller.expenses = expenses
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
