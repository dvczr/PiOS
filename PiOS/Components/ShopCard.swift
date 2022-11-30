//
//  ShopCard.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-28.
//

import SwiftUI

struct ShopCard: View {
    @Namespace var card
    @State var shop: Shop
    @State var showStandardCard = false
    @State var showCompressedCard = false
    @State var showExpandedCard = false
    var isListView: Bool
    
    var body: some View {
        Group() {
            if showExpandedCard && !isListView {
                CardExpanded(
                    card: card,
                    shop: shop,
                    isListView: false
                )
                .onTapGesture {
                    self.showCompressedCard.toggle()
                    self.showExpandedCard.toggle()
                }
            }
            else if showCompressedCard && !isListView {
                CardCompressed(card: card, shop: shop, isListView: false
                )
                .onTapGesture {
                    self.showCompressedCard.toggle()
                    self.showExpandedCard.toggle()
                }
            }
            else if showStandardCard && isListView {
                CardStandard(
                    card: card,
                    shop: shop,
                    isListView: true)
                .onTapGesture {
                    self.showStandardCard.toggle()
                    self.showExpandedCard.toggle()
                }
            }
            else if showExpandedCard && isListView {
                CardExpanded(
                    card: card,
                    shop: shop,
                    isListView: true)
                .onTapGesture {
                    self.showStandardCard.toggle()
                    self.showExpandedCard.toggle()
                }
            }
        }
        .onTapGesture {
            withAnimation{
                showStandardCard.toggle()
                showCompressedCard.toggle()
                showExpandedCard.toggle()
            }
        }
    }
}

struct CardStandard: View {
    var card: Namespace.ID
    var shop: Shop
    var isListView: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .matchedGeometryEffect(
                    id: "card",
                    in: card,
                    properties: .position)
            HStack(alignment: .top) {
                AsyncImage(
                    url: URL(string: shop.image),
                    content: { image in
                        image.resizable() },
                    placeholder: { LoadingIndicator(isSmall: false) } )
                .matchedGeometryEffect(id: "image", in: card)
                .frame(
                    width: 175,
                    height: 175)
                Divider()
                Spacer()
                VStack(alignment: .leading) {
                    Text(shop.name)
                        .font(.title.lowercaseSmallCaps())
                        .padding(10)
                        .matchedGeometryEffect(id: "name", in: card)
                    Divider()
                    ScrollView(.horizontal, showsIndicators: false) {
                    Text(shop.adress)
                        .font(.footnote)
                        .padding(10)
                        .matchedGeometryEffect(id: "adress", in: card)
                    }
                    Divider()
                    ScrollView(.vertical, showsIndicators: false) {
                        Text(shop.businessHours)
                            .font(.footnote)
                            .padding(10)
                            .matchedGeometryEffect(id: "businessHours", in: card)
                    }
                }
            }
            
        }
        .monospaced()
        .frame(
            width: UIScreen.main.bounds.width * 0.9,
            height: UIScreen.main.bounds.height * 0.18)
        .cornerRadius(7, antialiased: true)
        .padding(12)
        .shadow(color: .black, radius: 7)
    }
}

struct CardCompressed: View {
    var card: Namespace.ID
    var shop: Shop
    var isListView: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .matchedGeometryEffect(
                    id: "card",
                    in: card,
                    properties: .position)
            HStack(alignment: .center) {
                AsyncImage(
                    url: URL(string: shop.image),
                    content: { image in
                        image.resizable() },
                    placeholder: { LoadingIndicator(isSmall: true)} )
                .frame(
                    width: 100,
                    height: 100)
                .matchedGeometryEffect(
                    id: "image",
                    in: card)
                Divider()
                Spacer()
                VStack(alignment: .leading) {
                    Text(shop.name)
                        .font(.title.lowercaseSmallCaps())
                        .padding(.top, 15)
                        .frame(alignment: .center)
                        .matchedGeometryEffect(id: "name", in: card)
                    Divider()
                    Text(shop.adress)
                        .font(.footnote)
//                        .padding(5)
                        .matchedGeometryEffect(id: "adress", in: card)
                    Divider().hidden()
                    Text(shop.businessHours)
                        .font(.footnote)
                        .matchedGeometryEffect(id: "businessHours", in: card)
                        .hidden()
                }.multilineTextAlignment(.leading)
                    .padding(.vertical, 10)
                    .padding(.trailing, 10)
            }
        }
        .monospaced()
        .frame(
            width: UIScreen.main.bounds.width * 0.9,
            height: UIScreen.main.bounds.height * 0.10)
        .cornerRadius(7, antialiased: true)
        .shadow(color: .black, radius: 7)
    }
}

struct CardExpanded: View {
    var card: Namespace.ID
    var shop: Shop
    var isListView: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .matchedGeometryEffect(
                    id: "card",
                    in: card,
                    properties: .position)
            ZStack(alignment: .topTrailing){
                
                VStack(alignment: .leading) {
                    ZStack(alignment: .bottomTrailing) {
                        VStack(alignment: .center) {
                            
                            AsyncImage(
                                url: URL(string: shop.image),
                                content: { image in
                                    image.resizable() },
                                placeholder: { LoadingIndicator(isSmall: false) } )
                            .matchedGeometryEffect(id: "image", in: card)
                            .frame(
                                width: UIScreen.main.bounds.width * 0.9,
                                height: UIScreen.main.bounds.height * 0.6,
                                alignment: .center)
                        }.frame(alignment: .top)
                        HStack(alignment: .top) {
                            Text(shop.businessHours)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .matchedGeometryEffect(id: "businessHours", in: card)
                        }.padding(10)
                            .background(RoundedCornersShape(corners: [.topLeft], radius: 10))
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .opacity(0.85)
                    }
                    
                    VStack(alignment: .leading) {
                        ScrollView(.vertical, showsIndicators: false) {
                            Text(shop.description)
                                .font(.body)
                                .matchedGeometryEffect(id: "description", in: card)
                        }.padding()
                    }
                }
                VStack(alignment: .trailing, spacing: 0) {
                    Text(shop.name)
                        .font(.largeTitle.lowercaseSmallCaps())
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.horizontal, 10)
                        .background(RoundedCornersShape(corners: [.topRight], radius: 10))
                        .matchedGeometryEffect(id: "name", in: card)
                    Text(shop.adress)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(RoundedCornersShape(corners: [.bottomLeft, .topLeft], radius: 10))
                        .matchedGeometryEffect(id: "adress", in: card)
                }
//                    .background(RoundedCornersShape(corners: [.bottomLeft], radius: 10))
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                    .opacity(0.85)
                
//                .foregroundStyle(Color.primary).colorInvert().padding()
            }
        }
        .monospaced()
        .frame(
            width: UIScreen.main.bounds.width * 0.9,
            height: UIScreen.main.bounds.height * 0.79)
        .cornerRadius(7, antialiased: true)
        .padding()
        .shadow(color: .black, radius: 7)
    }
}



struct ShopCard_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        //        CardStandard(
        //            card: namespace,
        //            shop: Shop(
        //                id: UUID(),
        //                name: "blabla",
        //                image: "URL",
        //                adress: "Adress",
        //                businessHour: "Bussiness Hour",
        //                description: "Description",
        //                latitude: 10.123456,
        //                longitude: -12.123456),
        //            isListView: false)
        
                CardCompressed(
                    card: namespace,
                    shop: Shop(
                        id: "Strinsdfg",
                        name: "blabla",
                        image: "URL",
                        adress: "Adress",
                        businessHours: "Bussiness Hour",
                        description: "Description",
                        latitude: "10.123456",
                        longitude: "-12.123456"),
                    isListView: false)
//
//        CardExpanded(
//            card: namespace,
//            shop: Shop(
//                id: "Strinsdfg",
//                name: "blabla",
//                image: "URL",
//                adress: "Adress",
//                businessHours: "Bussiness Hour",
//                description: "Description",
//                latitude: "10.123456",
//                longitude: "-12.123456"),
//            isListView: false)
        
        
        //        ShopCard(
        //            shop: Shop(
        //                id: "12",
        //                name: "Vapify",
        //                image:
        //                    "https://lh5.googleusercontent.com/p/AF1QipMaZlnUtuhwo5czHql4eQj3LEEbgID2BLSFwHdN=w408-h306-k-no",
        //                adress: "Hornsgatan 52, 118 21 Stockholm​",
        //                businessHours: "Open Hours",
        //                description: "Good Freekin'g CloudShop",
        //                latitude: "59.341064261014644",
        //                longitude: "18.05983350571576"
        //            ), isListView: .random()
        //        )
    }
}
