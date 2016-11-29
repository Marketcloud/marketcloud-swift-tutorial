import Foundation
import Marketcloud
import SwiftyJSON

class CartController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblItems: UITableView!
    
    //empty array for the cart items
    var items:JSON = []
    
    let marketcloud:Marketcloud = MarketcloudMain.getMarketcloud()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        let cart:JSON = JSON(marketcloud.getCart()["data"]!)
        items = cart["items"]
        
        //populate the tab.... now!
        tblItems.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        
        //we will show the product's name and price with its quantity
        cell.textLabel?.text = "\(items[indexPath.row]["name"])"
        cell.detailTextLabel?.text = "\(items[indexPath.row]["price"])€ x\(items[indexPath.row]["quantity"])"
        
        return cell
    }
    
}
