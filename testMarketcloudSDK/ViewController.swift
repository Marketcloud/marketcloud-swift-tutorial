import UIKit
import SwiftyJSON
import Marketcloud

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let marketcloud:Marketcloud = MarketcloudMain.getMarketcloud()
        
        print(marketcloud.utils.getVersion())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

