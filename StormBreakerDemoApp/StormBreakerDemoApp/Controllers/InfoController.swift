//
//  InfoController.swift
//  StormBreakerDemoApp
//
//  Created by Shival Pandya on 2020-01-19.
//  Copyright © 2020 Shival Pandya. All rights reserved.
//

import UIKit

class InfoController: UIViewController {

    @IBOutlet weak var btnOK: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnOK.backgroundColor = UIColor.customGreen() ?? UIColor.green
        btnOK.tintColor = UIColor.customWhite() ?? UIColor.white
        
        textView.layer.borderColor = UIColor.customBlack()?.cgColor
        textView.layer.borderWidth = 1
    }
    
    @IBAction func btnOKClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
