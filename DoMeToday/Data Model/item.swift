//
//  item.swift
//  DoMeToday
//
//  Created by Randolph Davis Hill on 7/4/19.
//  Copyright © 2019 Randolph Davis Hill. All rights reserved.
//

import Foundation
class Item: Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
}
