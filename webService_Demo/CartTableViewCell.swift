//
//  CartTableViewCell.swift
//  webService_Demo
//
//  Created by Mac on 09/04/25.
//

import UIKit
import Kingfisher
class CartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    var prodt : [Products] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        register()
        self.cartCollectionView.dataSource = self
        self.cartCollectionView.delegate = self
    }
    
    func register(){
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.cartCollectionView.register(nib, forCellWithReuseIdentifier: "Product")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension CartTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        prodt.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.cartCollectionView.dequeueReusableCell(withReuseIdentifier: "Product", for: indexPath) as! CollectionViewCell
    
        let url = URL(string: prodt[indexPath.row].thumbnail)
        cell.collectionImage.kf.setImage(with: url,placeholder: UIImage(systemName: "star"))
        return cell
    }
}
extension CartTableViewCell : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 20)/3, height: collectionView.frame.height)
    }
}
