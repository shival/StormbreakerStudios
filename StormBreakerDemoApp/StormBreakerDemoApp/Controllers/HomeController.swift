//
//  HomeController.swift
//  StormBreakerDemoApp
//
//  Created by Shival Pandya on 2020-01-19.
//  Copyright © 2020 Shival Pandya. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleTitle2: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnMonthly: UIButton!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var viewModel = DataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        categoryCollectionView.reloadData()
    }

    fileprivate func setupUI() {
        
        if let logoImage = UIImage(named: "nav-logo") {
            let imageView = UIImageView(image: logoImage)
            navigationItem.titleView = imageView
        }
        
        if let black = UIColor.customBlack() {
            articleTitle.textColor = black
        }
        
        if let white = UIColor.customWhite() {
            articleTitle2.textColor = white
            btnDone.setTitleColor(white, for: .normal)
            btnMonthly.setTitleColor(white, for: .normal)
        }
        
        if let lightGray = UIColor.customPurple() {
            btnDone.backgroundColor = lightGray
        }
        
        if let green = UIColor.customGreen() {
            btnMonthly.backgroundColor = green
        }
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if let dailyView = sb.instantiateViewController(withIdentifier: "DailyController") as? DailyController {
            navigationController?.pushViewController(dailyView, animated: true)
        }
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var _: UICollectionReusableView? = nil
        switch kind {

        case UICollectionView.elementKindSectionHeader:

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellHeader", for: indexPath as IndexPath)
            let labelHeader = headerView.viewWithTag(2) as! UILabel
            
            let title = viewModel.getSectionTitle(at: indexPath.section)
            labelHeader.text = title

            headerView.backgroundColor = UIColor.clear
            headerView.addSubview(labelHeader) //Add UILabel on HeaderView
            return headerView

        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let data = viewModel.getSectionData(at: indexPath.section)
        cell.setupView(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: view.frame.width, height: 160)
       }
}

