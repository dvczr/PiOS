//
//  Shop.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-25.
//

import Foundation
import CoreLocation

struct Shop: Encodable, Decodable, Identifiable {
    
//    var id = UUID()
    var id: String
    var name: String
    var image: String
    var adress: String
    var businessHours: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    
    
    

    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
   
    init(id: String, name: String, image: String, adress:String, businessHours: String, description: String, latitude: String, longitude: String) {
        
        
        
        self.id = id
        self.name = name
        self.image = image
        self.adress = adress
        self.businessHours = businessHours
        self.description = description
        self.latitude = (latitude as NSString).doubleValue
        self.longitude = (longitude as NSString).doubleValue
    }
    
    
}
