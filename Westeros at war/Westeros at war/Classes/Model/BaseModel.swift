//
//  BaseModel
//
//  Created by Sachin
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

public class BaseModel: NSObject, Mappable {
    
    override required public init() {
        super.init()
    }
    
    required public init?(_ map: Map){
        super.init()
    }
    
    public func mapping(map: Map) {
        
    }
    
}