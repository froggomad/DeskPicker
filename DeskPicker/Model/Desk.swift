//
//  Desk.swift
//  Not A Shopping List
//
//  Created by Kenny on 12/21/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import Foundation

struct Desk: Equatable, Codable {
    var name: String
    var wasTouched: Bool = false
    
    init(name: String) {
        self.name = name
        print("Creating Desk: \(name)") //to make sure it's only created on load if its empty
    }
}
