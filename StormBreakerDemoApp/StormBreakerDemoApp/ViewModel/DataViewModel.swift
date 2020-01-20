//
//  DataViewModel.swift
//  StormBreakerDemoApp
//
//  Created by Shival Pandya on 2020-01-19.
//  Copyright © 2020 Shival Pandya. All rights reserved.
//

import Foundation

class DataViewModel {
    
    private var sectionTitle = ["Featured Articles", "Topics", "Time to Read"]
    private var sectionOne: [[String:String]] = [["image": "sec1", "title": "Lotus Focus"], ["image": "sec1-1", "title": "Peaceful Thoughts: How to"], ["image": "Sec1-3", "title": "Third Image"]]
    
    private var sectionTwo: [[String:String]] = [["image": "Peace", "title": "Peace"], ["image": "Balance", "title": "Balance"], ["image": "Sand", "title": "Sand"]]
    
    private var sectionThree: [[String:String]] = [["image": "5min", "title": "5 min"], ["image": "10min", "title": "10 min"], ["image": "flower", "title": "Flower"]]
    
    var sectionCount: Int {
        return sectionTitle.count
    }
    
    func getSectionTitle(at index: Int) -> String {
        if index <= sectionTitle.count {
            let title = sectionTitle[index]
            return title
        }
        return ""
    }
    
    func getSectionData(at index: Int) -> [[String:String]] {
        let sectionData = [sectionOne, sectionTwo, sectionThree]
        
         if index <= sectionTitle.count {
            let data = sectionData[index]
            return data
        }
        return [[String:String]]()
    }
}
