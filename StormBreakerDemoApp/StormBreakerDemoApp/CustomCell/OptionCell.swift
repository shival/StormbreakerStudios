//
//  OptionCell.swift
//  StormBreakerDemoApp
//
//  Created by Shival Pandya on 2020-01-20.
//  Copyright © 2020 Shival Pandya. All rights reserved.
//

import UIKit

class OptionCell: UICollectionViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionTextField: UITextField!
    
    private var pickerData = [String]()
    private let pickerView = UIPickerView()
    private var selectedValue = ""
    
    var textFieldClosure: ((String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
         createPickerView()
    }
    
    func setupUI(dictData: [String: Any]) {
        
        titleLabel.text = dictData["title"] as? String
        
        if let pickerType = dictData["pickerType"] as? PickerType {
            if pickerType == .YesNo {
                pickerData = ["No", "Yes"]
            } else {
                pickerData = ["Low", "Medium", "High"]
            }
        }
    }
    
    func createPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        optionTextField.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(OptionCell.btnDoneClicked))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        optionTextField.inputAccessoryView = toolBar
    }
    
    @objc func btnDoneClicked() {
        if selectedValue == "" {
            let value = pickerView.selectedRow(inComponent: 0)
            textFieldClosure?(pickerData[value])
        } else {
            textFieldClosure?(selectedValue)
        }
        endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // number of session
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count // number of dropdown items
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row] // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // selected item
        selectedValue = pickerData[row]
    }
}
