//
//  UserAcct.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-25.
//

import Foundation
import CoreLocation

struct UserAcct: Codable, Identifiable {
    
    var id: String
//    var icon: String
    var nameFirst: String
    var nameLast: String
    var email: String
    //    var birthday: Date  // ??? ska vi ha kvar den
    
//    init(id: String, nameFirst: String, nameLast: String, email: String) {
//        self.id = id
//        self.nameFirst = nameFirst
//        self.nameLast = nameLast
//        self.email = email
//    }
    
}

