//
//  ContentView.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State private var searchInput = ""
    @State private var isMapView: Bool = false
    @Binding var isSearching: Bool
    @Binding var isLoginIn: Bool
    
    
    var body: some View {
        
        
//        if dbConnection.userLoggedIn {
            NavigationStack {
                MapView(isMapView: $isMapView, searchInput: $searchInput, email: "", password: "")
            }
        }
        
//        else {
//            NavigationStack {
//                LoginPopup( isLoginIn: $isLoginIn)
//
////                    self.isLoginIn = false
//
//            }
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(isSearching: .constant(.random()), isLoginIn: .constant(.random()))
        
//        ShopCard(shop: Shop(
//            id: "12",
//            name: "Vapify",
//            image:
//                "https://lh5.googleusercontent.com/p/AF1QipMaZlnUtuhwo5czHql4eQj3LEEbgID2BLSFwHdN=w408-h306-k-no",
//            adress: "Hornsgatan 52, 118 21 Stockholm​",
//            businessHours: "Open Hours",
//            description: "Good Freekin'g CloudShop",
//            latitude: "59.341064261014644",
//            longitude: "18.05983350571576"
//        ), isListView: .random())
        

//        ContentView(isSearching: .constant(.random()))
//
//        ContentView()
//        ContentView(
//            isSearching: .constant(.random()),
//            shopList: [
//                Shop(
//                    name: "Home",
//                    image: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
//                    adress: "Sten",
//                    businessHour: "Open Hours",
//                    description: "Good Freekin'g CloudShop",
//                    latitude: 59.19377,
//                    longitude: 17.84212
//                ),
//                Shop(
//                    name: "STI",
//                    image: "https://as1.ftcdn.net/v2/jpg/05/26/66/32/1000_F_526663207_FxdDUt7rgJR4ximFRsH85SYLDwgZntdN.jpg",
//                    adress: "Liljeholmstorget 7, 117 63 Stockholm, Sverige",
//                    businessHour: "Open Hours",
//                    description: "Good Freekin'g CloudShop",
//                    latitude: 59.309880,
//                    longitude: 18.021956
//                ),
//                Shop(
//                    name: "One Park Drive",
//                    image: "https://cdn.pixabay.com/photo/2013/07/18/20/26/sea-164989_1280.jpg",
//                    adress: "1 Apple Park Way, Cupertino Califormia, USA",
//                    businessHour: "Open Hours",
//                    description: "Good Freekin'g CloudShop",
//                    latitude: 37.334886,
//                    longitude: -122.008988
//                )
//            ]
//        )
    }
}
