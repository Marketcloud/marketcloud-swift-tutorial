import Foundation
import Marketcloud

open class MarketcloudMain {
    
    internal static var marketcloud:Marketcloud? = nil
    fileprivate static let publicKey:String = "2cd15ec1-833c-4713-afbf-b7510e357bc8"
    static var userEmail:String? = nil
    
    static func getMarketcloud() -> Marketcloud {
        
        if(marketcloud != nil) {
            return marketcloud!
        }
        else {
            marketcloud = Marketcloud(key:publicKey)
            print("setted marketcloud var with key \(publicKey)")
            return marketcloud!
        }
    }
}
