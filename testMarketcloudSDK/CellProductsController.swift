import UIKit

//A controller for the custom cells in a tableView
class CellProductsController: UITableViewCell {
    
    @IBOutlet weak var imgCell: UIImageView!
    
    @IBOutlet weak var titleCell: UILabel!
    
    @IBOutlet weak var descrCell: UILabel!
   
    @IBOutlet weak var priceCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated:Bool) {
        super.setSelected(selected, animated: animated)
    }

}
