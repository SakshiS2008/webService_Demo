//
//  ViewController.swift
//  webService_Demo
//
//  Created by Sakshi on 08/04/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cartTableView: UITableView!
    
    var url : URL?
       var urlRequest : URLRequest?
       var urlSession : URLSession?
       var carts : [Cart] = []
       var products : [Products] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSettings()
        jsonSerialization()
        register()
    }
    
    func register(){
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        self.cartTableView.register(nib, forCellReuseIdentifier: "Cart")
    }
    func initSettings(){
        self.cartTableView.dataSource = self
        self.cartTableView.delegate = self
           url = URL(string :  Constants.urlString)
           urlRequest = URLRequest(url: url!)
           urlSession = URLSession(configuration: .default)
    }
    
    func jsonSerialization(){
           let dataTask = urlSession?.dataTask(with: urlRequest!){ [self] data, response, error in
               
           let apiResponse = try! JSONSerialization.jsonObject(with: data!) as! [String:Any]
               
               let extractedCarts = apiResponse["carts"] as! [[String:Any]]
               let total = apiResponse["total"] as! Int
               let skip = apiResponse["skip"] as! Int
               let limit = apiResponse["limit"] as! Int
               
               for eachCart in extractedCarts{
                   let cartId = eachCart["id"] as! Int
                   let cartProducts = eachCart["products"] as! [[String:Any]]
                   let cartTotal = eachCart["total"] as! Double
                   let cartDiscountedTotal = eachCart["discountedTotal"] as! Double
                   let cartUserId = eachCart["userId"] as! Int
                   let cartTotalProducts = eachCart["totalProducts"] as! Int
                   let cartTotalQuantity = eachCart["totalQuantity"] as! Int
                   
                   var prodt : [Products] = []
               for eachProduct in cartProducts{
                   let prId = eachProduct["id"] as! Int
                   let prTitle = eachProduct["title"] as! String
                   let prPrice = eachProduct["price"] as! Double
                   let prQuantity = eachProduct["quantity"] as! Int
                   let prTotal = eachProduct["total"] as! Double
                   let prDiscountPercentage = eachProduct["discountPercentage"] as!Double
                   let prDiscountedTotal = eachProduct["discountedTotal"] as! Double
                   let prThumbnail = eachProduct["thumbnail"] as! String
                       
                       prodt.append(Products(id: prId,
                                                    title: prTitle,
                                                    price: prPrice,
                                                    quantity: prQuantity,
                                                    total: prTotal,
                                                    discountPercentage: prDiscountPercentage,
                                                    discountedTotal: prDiscountedTotal,
                                                    thumbnail: prThumbnail))
                    
                   }
                   
                   self.carts.append(Cart(id: cartId,
                                          product: prodt,
                                          total: cartTotal,
                                          discoutedTotal: cartDiscountedTotal,
                                          userId: cartUserId,
                                          totalProducts: cartTotalProducts,
                                          totalQuantity: cartTotalQuantity))
                   print(self.carts)
               }
               DispatchQueue.main.async{
                   self.cartTableView.reloadData()
               }
           }
           dataTask?.resume()
       }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        carts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cartTableView.dequeueReusableCell(withIdentifier: "Cart", for: indexPath) as! CartTableViewCell
        cell.idLabel.text = "\(carts[indexPath.row].id)"
        cell.prodt = carts[indexPath.row].product
        
        return cell
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}



