//
//  LoginPopup.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-29.
//

import SwiftUI

struct LoginPopup: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @Binding var isLoginIn: Bool
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            InputFieldLogin(email: $email, password: $password)
                .frame(alignment: .center)
            HStack {
                Button(action: {
                    print("E-mail: \(email)\nPassword: \(password)")
                    dbConnection.Login(email: email, password: password)
                    
                }, label: {
                    
                    Text("Login")
                    
                })
                .buttonStyle(.bordered)
                .background(.ultraThinMaterial)
                .frame(alignment: .leading).frame(alignment: .center)
                
                Button(action: {
                    self.isLoginIn = false
                }, label: {
                    
                    Text("Cancel")
                    
                })
                .buttonStyle(.bordered)
                .background(.ultraThinMaterial)
                .frame(alignment: .leading).frame(alignment: .center)
                
                
                
                
            }.cornerRadius(7)
            Spacer()
            
            Button(action: {dbConnection.LogOut()}) {
                Text("SignOut")
            }
            .frame(alignment: .center)
            NavigationLink(destination: {CreateAccountView()}, label: {Text("Create Account")})
            Spacer()
        }
        .frame(alignment: .center).edgesIgnoringSafeArea(.top)
    }
}

struct LoginPopup_Previews: PreviewProvider {
    static var previews: some View {
        LoginPopup(isLoginIn: .constant(true))
    }
}
