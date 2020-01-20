//
//  DailyViewModel.swift
//  StormBreakerDemoApp
//
//  Created by Shival Pandya on 2020-01-20.
//  Copyright © 2020 Shival Pandya. All rights reserved.
//

import Foundation

enum PickerType:String {
    case YesNo = "YesNo"
    case Other = "Other"
}

class DailyViewModel {
    
   private var data: [[String : Any]] = [
        ["title": "Mood", "pickerType": PickerType.Other],
        ["title": "Comfort", "pickerType": PickerType.Other],
        ["title": "Stress Level", "pickerType": PickerType.Other],
        ["title": "Calm", "pickerType": PickerType.YesNo],
        ["title": "Thankfull", "pickerType": PickerType.YesNo],
        ["title": "Clarity", "pickerType": PickerType.Other],
        ["title": "Grateful", "pickerType": PickerType.YesNo],
        ["title": "Self-awareness", "pickerType": PickerType.Other],
        ["title": "Did something good", "pickerType": PickerType.YesNo],
        ["title": "Did something bad", "pickerType": PickerType.Other],
        ["title": "Selflessness", "pickerType": PickerType.Other]]
    
    private lazy var saveData = data
    
    var dataCount: Int {
        return data.count
    }
    
    func getData(at index: Int) -> [String:Any]? {
        
        if index <= dataCount - 1 {
            let dictData = data[index]
            return dictData
        }
        return nil
    }
    
    func saveData(at index: Int, value: String) {
        
        if index <= dataCount - 1 {
             var dictData = saveData[index]
            dictData["value"] = value
            
            saveData.remove(at: index)
            saveData.insert(dictData, at: index)
        }
    }
    
    func saveLocally() {
        
        do {
            let userDefault = UserDefaults.standard
            let archive = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
            userDefault.setValue(archive, forKey: "savedValue")
            
            print("test")
        } catch let ex {
            print("Error", ex.localizedDescription)
        }
    }
    
    func isSameDate(selectedDate: Date) -> Bool {
        
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        let stringDate = df.string(from: selectedDate)
        
        let stringDate2 = df.string(from: Date())
        
        if stringDate == stringDate2 {
            return true
        }
        
        return false
    }
}
