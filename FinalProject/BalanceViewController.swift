//
//  BalanceViewController.swift
//  FinalProject
//
//  Created by User18 on 2019/6/22.
//  Copyright © 2019 User02. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var incomes = [Record]()
    var expenses = [Record]()
    var totalIncome: Double = 0.0
    var totalExpense: Double = 0.0
    var balance: Double = 0.0

    // tables
    @IBOutlet weak var incomeTable: UITableView!
    @IBOutlet weak var expenseTable: UITableView!
    
    // labels
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set background
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
        // get totalIncome and totalExpense
        for income in incomes{
            totalIncome += income.cost
        }
        for expense in expenses{
            totalExpense += expense.cost
        }
        balance = totalIncome - totalExpense

        
        // set Labels
        incomeLabel.text = NSString(format:"%.2f", totalIncome) as String
        expenseLabel.text = NSString(format:"%.2f",totalExpense) as String
        balanceLabel.text = NSString(format: "%.2f", balance) as String
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == incomeTable{
            return incomes.count
        }
        else if tableView == expenseTable{
            return expenses.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == incomeTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as! BalanceTableViewCell
            let income = incomes[indexPath.row]
            cell.eventLabel?.text = income.event
            cell.timeLabel?.text = income.time
            let costStr = NSString(format:"%.2f", income.cost) as String
            cell.costLabel?.text = costStr + "元"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! BalanceTableViewCell
            let expense = expenses[indexPath.row]
            cell.eventLabel?.text = expense.event
            cell.timeLabel?.text = expense.time
            let costStr = NSString(format:"%.2f", expense.cost) as String
            cell.costLabel?.text = costStr + "元"
            return cell
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
