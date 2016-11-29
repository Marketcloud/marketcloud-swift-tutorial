import Foundation
import Marketcloud
import SwiftyJSON

class ProductListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblProducts: UITableView!
    
    //empty array for the products
    var products:JSON = []
    
    let marketcloud:Marketcloud = MarketcloudMain.getMarketcloud()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //download the products!
        products = JSON(marketcloud.getProducts())["data"]
        
        //populate the tab.... now!
        tblProducts.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        
        //we're going to print the product's name and price
        cell.textLabel?.text = "\(products[indexPath.row]["name"])"
        cell.detailTextLabel?.text = "\(products[indexPath.row]["price"])€"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisProduct:JSON = products[indexPath.row]
        let productId:Int = thisProduct["id"].int!
        print("productId is \(productId)")
        
        let alertController = UIAlertController(title: "Add to cart", message: "Do you want to add this item to the cart?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title:"Close",style:UIAlertActionStyle.default, handler:nil))
        
        alertController.addAction(UIAlertAction(title:"Ok!",style:UIAlertActionStyle.default, handler:{ action in
            let cart:JSON = JSON(self.marketcloud.getCart())
            let cartData:JSON = cart["data"]
            print("cart id is \(cartData["id"])")
            
            var itemArray = [Any]()
            itemArray.append(["product_id":productId,"quantity":1])
            
            self.marketcloud.addToCart(cartData["id"].int!, data: itemArray)
        }))

        self.present(alertController, animated:true, completion: nil)
    }
}
