//
//  RecordViewController.swift
//  FinalProject
//
//  Created by User02 on 2018/12/26.
//  Copyright © 2018 User02. All rights reserved.
//

import UIKit


class RecordViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    var items = [Record]()
    @IBOutlet weak var tableView: UITableView!
    

    // flag buttons
    @IBOutlet weak var sourceFlagBtn: UIButton!
    @IBOutlet weak var destFlagBtn: UIButton!
    
    // text fields
    @IBOutlet weak var ExRateField: UILabel!
    
    // title
    @IBOutlet weak var titleLabel: UILabel!
    
    var sourceFlag:String?
    var destFlag: String?
    var Exrate: tradeInfo?
    
    // type of record
    var type: String?
    
    // amount of money
    var totalMoney: Double = 0
    
    var moving: Bool = false
    
    @IBAction func unwindSegueToRecord(segue : UIStoryboardSegue){
        if  let source = segue.source as? ScrollViewController,
            let record = source.record,
            let type = type
        {
                let row = source.row
                print("row : " + String(row))
                if row < items.count {
                    items.remove(at: row)
                }
                items.insert(record,at: (row) )
                Record.save(records:items, key: type)
                tableView.reloadData()
        }
        
    }
    
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
        
        // set background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
        // initialize flag image
        if let sourceFlag = sourceFlag, let destFlag = destFlag{
            sourceFlagBtn.setImage(UIImage(named: sourceFlag), for: .normal)
            destFlagBtn.setImage(UIImage(named: destFlag), for: .normal)
        }
    
        if let type = type, let records = Record.read(key: type) {
            self.items = records
        }
        
        if let type = type{
            if type == "income"{
                titleLabel.text = "收入列表"
            }
            else if type == "expense"{
                titleLabel.text = "支出列表"
            }
            else if type == "balance"{
                titleLabel.text = "盈餘列表"
            }
            
        }
        
        getExRate()
        
        tableView.delegate = self
        tableView.dataSource = self
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
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? ScrollViewController{
            if let row = tableView.indexPathForSelectedRow?.row {
                controller.record = items[row]
                controller.row = row
            }
            else{
                controller.row = items.count
            }
            controller.type = type
        }
        
        if let controller = segue.destination as? FlagViewController, let button = sender as? UIButton{
            if button.tag == 0{
                controller.currentFlag = "source"
            }
            else if button.tag == 1{
                controller.currentFlag = "dest"
            }
        }
        
        
        if  let navigationVC = segue.destination as? UINavigationController,
            let controller = navigationVC.topViewController as? MenuViewController,
            let sourceFlag = sourceFlag,
            let destFlag = destFlag{
            controller.sourceFlag = sourceFlag
            controller.destFlag = destFlag
            controller.sourceFlagBtn.setImage(UIImage(named: sourceFlag), for: .normal)
            controller.destFlagBtn.setImage(UIImage(named: destFlag), for: .normal)
            controller.getExRate()
        }
    }
    
    
    
    @IBAction func setMoving(_ sender: UIButton) {
        if moving == false{
            moving = true
            tableView.isEditing = true
            sender.setTitle("完成", for: .normal)
        }
        else{
            moving = false
            tableView.isEditing = false
            sender.setTitle("移動", for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        // 將移動的項目賦值給 temp
        let temp = items[sourceIndexPath.row]
        // 將原有位置的項目刪除
        items.remove(at: sourceIndexPath.row)
        // 將剛剛移動的項目插入到新的位置
        items.insert(temp, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if moving == true{
            return .none
        }
        else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // delete table row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("Delete")
            items.remove(at: indexPath.row)
            if let type = type{
                Record.save(records: items, key: type)
            }
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        let item = items[indexPath.row]
        cell.time?.text = item.time
        cell.event?.text = item.event
        let costStr = NSString(format : "%.2f", item.cost) as String
        cell.cost?.text = costStr + "元"
        return cell
    }
    

}
