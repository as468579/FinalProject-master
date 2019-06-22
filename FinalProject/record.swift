//
//  record.swift
//  FinalProject
//
//  Created by User02 on 2018/12/26.
//  Copyright © 2018 User02. All rights reserved.
//

import Foundation
struct traderesult:Codable{
    var Exrate: Double
    var UTC : String
}

//   var flagArray: [String] = ["USA", "Canada", "China", "Germany", "Italy", "Taiwan", "UnitedKingdom", "Japon"]
struct tradeInfo:Codable{
    var USDCAD : traderesult    // Canada
    var USDCNY : traderesult    // China
    var USDDEM : traderesult    // Germany
    var USDITL : traderesult    // Italy
    var USDTWD : traderesult    // Taiwan
    var USDGBP : traderesult    // United Kingdom
    var USDJPY : traderesult    // Japon
    var USDKRW : traderesult    // Korea
    var USDWST : traderesult    // Samoa
    var USDUYU : traderesult    // Uruguay
    var USDMXV : traderesult    // Mexico
    var USDGTQ : traderesult    // Guatemala
    var USDLYD : traderesult    // Libya
    
}


struct Record:Codable
{
    var time: String
    var event: String
    var cost: Double
    var remarks: String
    static func save(records: [Record], key: String)
    {
        let Encoder = PropertyListEncoder()
        if let data = try? Encoder.encode(records)
        {
            UserDefaults.standard.set(data, forKey: key)
        }
        
    }
    static func read(key: String) -> [Record]? {
        if let data = UserDefaults.standard.data(forKey: key), let records = try? PropertyListDecoder().decode([Record].self, from: data) {
            return records
        }
        else {
            return nil
        }
    }
}



