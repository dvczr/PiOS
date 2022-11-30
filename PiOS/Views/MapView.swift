//
//  MapView.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-23.
//

import SwiftUI
import MapKit
import UIKit


struct MapView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @Namespace var card
    
    @Binding var isMapView: Bool
    @Binding var searchInput: String
    @State var isSearching = false
    @State var showShopView = false
    
    var email: String
    var password: String
    
    
    @StateObject var manager = LocationManager()
    @State var tracking: MapUserTrackingMode = .none
    @State var isTracking = false
    @State var isLogginIn = false
    
    @State var isSelected: Shop?
    
    var signInIcon: String = ""
    
    var body: some View {
        ZStack( alignment: .bottom ) {
            Map(
                coordinateRegion: $manager.region,
                interactionModes: [.all],
                showsUserLocation: true,
                userTrackingMode: $tracking,
                annotationItems: dbConnection.shopList
            )
            { shop in
                MapAnnotation(
//                    coordinate: shop.coordinates,
                    coordinate: CLLocationCoordinate2D(latitude: shop.coordinates.latitude, longitude: shop.coordinates.longitude),
                    content: {
                        Button(
                            action: { withAnimation { isSelected = shop } },
                            label: {
                                Image(systemName: "mappin.and.ellipse")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(
                                        width: 55,
                                        height: 55,
                                        alignment: .center)
                                    .foregroundStyle(
                                        Color.red,
                                        Color.indigo,
                                        Color.black)
                            }
                        )
                    }
                )
            }
            .ignoresSafeArea()
            .onTapGesture { withAnimation {
                self.isSelected = nil
                self.isSearching = false
            }
            }.overlay(alignment: .top, content: {
                VStack {
                    if let isSelected = isSelected {
                        withAnimation {
                            ShopCard(shop: isSelected, showCompressedCard: true, isListView: false)
                        }
                    }
                }
            })
            .toolbar() {
                ToolbarItemGroup(placement: .status) {
                    HStack {
                        Button(
                            action: { withAnimation{
                                isTracking.toggle()
                                if isTracking {
                                    manager.locationManagerDidChangeAuthorization(manager.getManager())
                                    tracking = .follow
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { isTracking.toggle() }
                                }
                                else { tracking = .none }
                            }},
                            label: { withAnimation {
                                Image(systemName: !isTracking ? "location" : "location.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(
                                        width: 20,
                                        height: 20,
                                        alignment: .center)
                                    .foregroundColor(Color.accentColor)
                            }}
                        )
                        withAnimation{
                            NavigationLink(
                                destination:
                                    {
                                        ListView(
                                            isMapView: $isMapView,
                                            searchInput: $searchInput,
                                            isSearching: $isSearching
                                            
                                        )
                                    },
                                label: {
                                    HStack {
                                        Image(systemName: "list.bullet.circle")
                                    }
                                }
                            )}
                        .onTapGesture { withAnimation {isMapView = false } }
                        Button(
                            action: {
                                withAnimation{
                                    self.isSearching.toggle()
                                    self.searchInput = ""
                                }
                            },
                            label:
                                {
                                    withAnimation {
                                        Image(systemName: "magnifyingglass")
                                    }
                                }
                        )
                    }
                }
            }.navigationBarBackButtonHidden()
            HStack {
                VStack {
                    if isSearching {
                        withAnimation {
                            SearchPopup(
                                searchInput: $searchInput,
                                isSearching: $isSearching )
                            .opacity(isSearching ? 1 : 0)
                        }
                    }
                }
            }
            .padding(.bottom, 27)
        }
        .overlay(alignment: .center, content: {
            ZStack {
                if isLogginIn {
                    LoginPopup(isLoginIn: $isLogginIn, email: email, password: password)
                }
            }
            .toolbar() {
                ToolbarItem(
                    placement: .primaryAction,
                    content: {
                        Button(
                            action: { self.isLogginIn.toggle() },
                            label: { Image(systemName:"person.crop.circle.fill" ) }
                        )
                        
                    }
                    
                    
                )
                
            }
        }
        )
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(
//            isMapView: .constant(.random()),
//            searchInput: .constant("xxx2"),
//            email: "",
//            password: "",
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
//    }
//}
