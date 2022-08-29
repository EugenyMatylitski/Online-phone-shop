//
//  ViewController.swift
//  Test
//
//  Created by Eugeny Matylitski on 23.08.22.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet private weak var categoriesCollectionView : UICollectionView!
    @IBOutlet private weak var HotSalesCollectionView : UICollectionView!
    @IBOutlet private weak var BestsellerCollectionView: UICollectionView!
    @IBOutlet private weak var filterButton : UIButton!
    @IBOutlet private weak var cartCounter : UILabel!
    @IBOutlet private weak var tabBar : UIView!

    @IBOutlet private weak var searchBar : UIView!{
        didSet{
            searchBar.layer.cornerRadius = 15.0
            searchBar.layer.shadowColor = UIColor(r: 191, g: 197, b: 245, alph: 0.15).cgColor
            searchBar.layer.shadowRadius = 8
            searchBar.layer.shadowOpacity = 1
            searchBar.layer.shadowOffset = CGSize(width: 0, height: 0)
            
        }
    }
    @IBOutlet private weak var qrView : UIView!{
        didSet{
            qrView.layer.cornerRadius = qrView.frame.height / 2
        }
    }
    var content : HomeVCModel?{
        didSet{
            guard let content = content else {
                return
            }
            loadData(of: content)
            HotSalesCollectionView.reloadData()
        }
    }
    var hotSalesImageData : [Data?] = []{
        didSet{
            HotSalesCollectionView.reloadData()
        }
    }
    var bestSellersImageData : [String : Data] = [:] {
        didSet{
            if bestSellersImageData.count == content?.bestSeller.count{
            BestsellerCollectionView.reloadData()
            }
        }
    }

    
    let networkService = HomeViewModel()
    let categories = Categories().categories
    var oldIndexPath : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.isHidden = true
        setup()
        loadContent()
    }
    
    func setup(){
        cartCounter.isHidden = true
        self.tabBar.layer.cornerRadius = 30
        self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        filterButton.addTarget(self, action: #selector(filterDidTap), for: .touchUpInside)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        HotSalesCollectionView.delegate = self
        HotSalesCollectionView.dataSource = self
        BestsellerCollectionView.delegate = self
        BestsellerCollectionView.dataSource = self
        BestsellerCollectionView.layer.cornerRadius = 20.0
    }
    
    func loadContent(){
        networkService.loadHotSales(content: .mainScreenInfo) { response in
            self.content = response
        }
    }
    
    func loadData(of content:HomeVCModel){
        
        let urlHotSales = content.homeStore.map { homestore in
            return homestore.picture
        }
        let urlBestSellers = content.bestSeller.map { bestSeller in
            return (bestSeller.title, bestSeller.picture)
        }
        urlBestSellers.forEach { (title, picture) in
            if title == "Samsung Note 20 Ultra"{
                let galaxyNotePicture = "https://www.notebookcheck-ru.com/typo3temp/_processed_/5/a/csm_4_3_Teaser_Samsung_Galaxy_Note20_Ultra_5G_SM-N986B_MysticWhite_f4a260a140.jpg"
                self.networkService.loadBestSellers(urlString: galaxyNotePicture) { data in
                    self.bestSellersImageData[title] = data
                }
            }else {
                self.networkService.loadBestSellers(urlString: picture) { data in
                    self.bestSellersImageData[title] = data
                }
            }
        }
        self.networkService.loadPicture(urlStrings: urlHotSales ?? []) { data in
            self.hotSalesImageData = data}
    }
    
    @objc func filterDidTap(){
        let filterVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "\(FilterVC.self)")
        filterVC.modalPresentationStyle = .overCurrentContext
        present(filterVC, animated: true)
    }
}


extension MainVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView{
            return categories.count
        }else if collectionView == HotSalesCollectionView{
            return hotSalesImageData.count
        }else {
            return bestSellersImageData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView{
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell
        
            cell?.category = categories[indexPath.row]
        
        return cell ?? .init()
        }else if collectionView == HotSalesCollectionView {
            let cell = HotSalesCollectionView.dequeueReusableCell(withReuseIdentifier: "\(HotSalesCell.self)", for: indexPath) as? HotSalesCell
            cell?.setup(info: content?.homeStore[indexPath.item] )
            if self.hotSalesImageData != []{
            cell?.imageFromData = UIImage(data: self.hotSalesImageData[indexPath.item] ?? Data())
            }
            return cell ?? .init()
        }else{
            let cell = BestsellerCollectionView.dequeueReusableCell(withReuseIdentifier: "\(BestSellerCell.self)", for: indexPath) as? BestSellerCell
            let phone = content?.bestSeller[indexPath.item]
            
            if self.bestSellersImageData != [:]{
                let imageData = bestSellersImageData.first { (phoneName, data) in
                    phoneName == phone?.title
                }
                cell?.setup(phone: phone, imageData: imageData?.value)
            }else {
                cell?.setup(phone: phone, imageData: nil)
            }
            return cell ?? .init()
    }
}

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView{
        return CGSize(width: 71, height: 90)
        }else if collectionView == HotSalesCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 150)
        }else {
            return CGSize(width: (BestsellerCollectionView.frame.width / 2) - 6, height: 227)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == BestsellerCollectionView{
            let detailsVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "\(ProductDetailsVC.self)")
            print("tapped")
            present(detailsVC, animated: true)
        }else if collectionView == categoriesCollectionView{
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as? CategoryCell
            if let oldIndexPath = self.oldIndexPath{
                categoriesCollectionView.deselectItem(at: oldIndexPath, animated: false)
            }
            self.oldIndexPath = indexPath
        }
        
    }

    
}
