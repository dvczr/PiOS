//
//  ListView.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-24.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @Namespace var card
    
    @Binding var isMapView: Bool
    @Binding var searchInput: String
    @Binding var isSearching: Bool
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                Divider()
                ScrollView(showsIndicators: false) {
                    ForEach(dbConnection.shopList) { shop in
                      
                        withAnimation {
                            ShopCard(shop: shop, showStandardCard: true, isListView: true) }
                    }
                }.frame(alignment: .center)
                
                    .toolbar() {
                        ToolbarItemGroup(placement: .status) {
                            HStack {
                                
                                NavigationLink(
                                    destination:
                                        {
                                            MapView(
                                                isMapView: $isMapView,
                                                searchInput: $searchInput,
                                                isSearching: isSearching,
                                                email: "",
                                                password: ""
//                                                shopList: dbConnection.shopList
                                            )
                                        },
                                    label: { Image(systemName: "map") }
                                )
                                .onTapGesture { isMapView = false }
                                
                                Button(
                                    action: {
                                        isSearching.toggle()
                                        searchInput = ""
                                    },
                                    label: {
                                        Image(systemName: "magnifyingglass")
                                    }
                                )
                            }.navigationBarBackButtonHidden()
                        }
                    }
                HStack {
                    VStack {
                        if isSearching {
                            SearchPopup(searchInput: $searchInput, isSearching: $isSearching)
                                .opacity(isSearching ? 1 : 0)
                        }
                    }
                }.padding(.bottom, 27)
                    .onTapGesture { isSearching = true }
            }
            .onTapGesture { isSearching = false }
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
        
        
//        ListView(
//            isMapView: .constant(.random()),
//            searchInput: .constant("Search..."),
//            isSearching: .constant(.random()),
//            shopList:
//                [
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
//    }
//}
