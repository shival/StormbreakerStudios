//
//  DailyController.swift
//  StormBreakerDemoApp
//
//  Created by Shival Pandya on 2020-01-19.
//  Copyright © 2020 Shival Pandya. All rights reserved.
//

import UIKit

class DailyController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var optionCollectionView: UICollectionView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    private var selectedDate = Date()
    
    private let viewModel = DailyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Daily View"
        navigationItem.hidesBackButton = true
        
        setupUI()
        setNavigationBar()
        showDate(date: Date())
    }
    
    fileprivate func setupUI() {
        textView.layer.cornerRadius = 10
        let titleColor = UIColor.customWhite() ?? UIColor.white
        btnSave.setTitleColor(titleColor, for: .normal)
        btnSave.backgroundColor = UIColor.customPurple() ?? UIColor.lightGray
    }
    
    fileprivate func showDate(date: Date) {
        
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        let stringDate = df.string(from: date)
        dateLabel.text = stringDate
    }
    
    fileprivate func setNavigationBar() {
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        
        if let imgBackArrow = UIImage(named: "arrowLeftDark") {
            imageView.image = imgBackArrow
            imageView.contentMode = .scaleAspectFill
        }
        backView.addSubview(imageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        backView.addGestureRecognizer(backTap)
        let leftBarButtonItem = UIBarButtonItem(customView: backView)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationController?.navigationBar.backItem?.title = "Home"
        
        let infoButton = UIButton(type: .infoDark)
        infoButton.addTarget(self, action: #selector(infoClicked), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
    }
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func infoClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if let dailyView = sb.instantiateViewController(withIdentifier: "InfoController") as? InfoController {
            dailyView.modalPresentationStyle = UIModalPresentationStyle.popover
            dailyView.preferredContentSize = CGSize(width: 400, height: 350)
            
            if let popover = dailyView.popoverPresentationController {
                popover.delegate = self
                popover.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                popover.sourceView = self.view
                popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY,width: 0,height: 0)
                present(dailyView, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        viewModel.saveLocally()
        
    }
    
    @IBAction func nextDay(_ sender: Any) {
        
        if viewModel.isSameDate(selectedDate: selectedDate) {
            var dayComponent = DateComponents()
            dayComponent.day = 1
            let cal = Calendar.current
            if let nextDate = cal.date(byAdding: dayComponent, to: selectedDate) {
                selectedDate = nextDate
                showDate(date: nextDate)
                optionCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func previousDay(_ sender: Any) {
        
        if !viewModel.isSameDate(selectedDate: selectedDate) {
            var dayComponent = DateComponents()
            dayComponent.day = -1
            let cal = Calendar.current
            if let nextDate = cal.date(byAdding: dayComponent, to: selectedDate) {
                selectedDate = nextDate
                showDate(date: nextDate)
                optionCollectionView.reloadData()
            }
        }
    }
}

extension DailyController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCell", for: indexPath) as! OptionCell
        
        if let dictData = viewModel.getData(at: indexPath.row) {
            cell.setupUI(dictData: dictData)
            
            cell.textFieldClosure = { [weak self] text in
                cell.optionTextField.text = text
                self?.viewModel.saveData(at: indexPath.row, value: text)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (optionCollectionView.frame.width / 2) - 10, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension DailyController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
