//
//  CreateAccountView.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-29.
//

import SwiftUI

struct CreateAccountView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    
    @State var name = ""
    @State var image = ""
    @State var adress = ""
    @State var businessHours = ""
    @State var description = ""
    @State var longitude = ""
    @State var latitude = ""
    
    @State var isUserAccount = true
    
    @State private var date = Date().addingTimeInterval(-567648000)
    
    var acctShop = "Shop"
    let acctUser = "User"
    
    var body: some View {
        
        ZStack {
            VStack{
                VStack {
                    Toggle(isOn: $isUserAccount) {
                        Text(isUserAccount ? "Account Type:\t\(acctUser)" : "Account Type:\t\(acctShop)")
                            .font(.callout)
                            .bold()
                            .frame(
                                maxWidth: .infinity,
                                alignment: .topTrailing)
                    }.padding(.horizontal)
                }.frame(alignment: .top)
                
                VStack {
                    AccountTemplate(
                        firstName: $firstName,
                        lastName: $lastName,
                        email: $email,
                        password: $password,
                        name: $name,
                        image: $image,
                        adress: $adress,
                        businessHours: $businessHours,
                        description: $description,
                        latitude: $latitude,
                        longtitude: $longitude,
                        isShopAccount: $isUserAccount,
                        date: $date
                    )
                }.frame(alignment: .top)
                
                Spacer()
                
                VStack {
                    
                    Button(
                        action: {
                            if isUserAccount {
                                CreateNewUserAccount(firstName: firstName,
                                                     lastName: lastName,
                                                     email: email,
                                                     password: password,
                                                     isUserAccount: isUserAccount )
                            } else if !isUserAccount {
                                CreateNewShopAccount(name: name,
                                                     image: image,
                                                     adress: adress,
                                                     businessHours: businessHours,
                                                     description: description,
                                                     latitude: latitude,
                                                     longitude: longitude,
                                                     isShopAccount: isUserAccount) } },
                        label: { Text("Create account").font(.headline.lowercaseSmallCaps()) }
                    )
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(7)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.013)
                    .buttonStyle(.plain)
                }.frame(alignment: .bottom)
            }
        }.fontDesign(.monospaced)
    }
    
    func CreateNewUserAccount(firstName: String,
                              lastName: String,
                              email: String,
                              password: String,
                              isUserAccount: Bool) {
        if isUserAccount &&
            firstName != "" &&
            lastName != "" &&
            email != "" &&
            password.count <= 6 {
            dbConnection.CreateUserAccount(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                isUserAccount: isUserAccount)
        }
    }
    
    func CreateNewShopAccount(name: String,
                              image: String,
                              adress: String,
                              businessHours: String,
                              description: String,
                              latitude: String,
                              longitude: String,
                              isShopAccount: Bool) {
        if !isShopAccount &&
            name != "" &&
            image != "" &&
            adress != "" &&
            businessHours != "" &&
            description != "" &&
            latitude != "" &&
            longitude != "" &&
            isShopAccount == Bool() {
            
            dbConnection.CreateShopAccount(
                email: email,
                password: password,
                name: name,
                image: image,
                adress: adress,
                businessHours: businessHours,
                description: description,
                latitude: latitude,
                longitude: longitude,
                isShopAccount: isShopAccount)
        }
    }
}
struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView().navigationTitle(.constant("Create Account"))
    }
}
