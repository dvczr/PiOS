//
//  AccountTemplate.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-25.
//

import SwiftUI

struct AccountTemplate: View {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var password: String
    
    @Binding var name: String
    @Binding var image: String
    @Binding var adress: String
    @Binding var businessHours: String
    @Binding var description: String
    @Binding var latitude: String
    @Binding var longtitude: String
    
    @Binding var isShopAccount: Bool
    
    @Binding var date: Date
    
    
    
    
    var body: some View {
        if isShopAccount {
            VStack{
                VInputField(
                    title: "Firstname",
                    placeholder: "John",
                    input: $firstName )
                VInputField(
                    title: "Lastname",
                    placeholder: "Doe",
                    input: $lastName )
                DateField(
                    date: $date )
                InputFieldLogin(
                    email: $email,
                    password: $password )
            }
            .navigationTitle("Create User Account")
            
        } else {
            VStack{
                HInputField(
                    title: "Shop",
                    placeholder: "Name",
                    input: $name )
                HInputField(
                    title: "Image",
                    placeholder: "Image URL",
                    input: $image )
                HInputField(
                    title: "Adress",
                    placeholder: "Shop Adress",
                    input: $adress )
                VInputField(
                    title: "Business Hours",
                    placeholder: "Monday - Friday: 11:00-20:00\nSaturday-Sunday: 12:00-18:00\n\n\n a",
                    mLine: "2",
                    aLine: true,
                    input: $businessHours )
                VInputField(
                    title: "Description",
                    placeholder: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet ornare leo. Suspendisse tincidunt lorem a consequat convallis. Nunc in tortor porta, sollicitudin dolor in, placerat dui. Sed dui.",
                    mLine: "3",
                    aLine: true,
                    input: $description )
                GPSField(
                    title: "Shop Location (GPS)",
                    longitude: $longtitude,
                    latitude: $latitude )
                InputFieldLogin(
                    email: $email,
                    password: $password )
            }.navigationTitle("Create Shop Account")
        }
    }
}

struct VInputField: View {
    var title: String
    var placeholder: String
    var mLine: String = "1"
    var aLine: Bool = false
    @Binding var input: String
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                
                Text(title)
                    .font(.callout.lowercaseSmallCaps())
                    .bold()
                
                TextField(
                    placeholder,
                    text: $input,
                    axis: .vertical
                    
                )
                .lineLimit(Int(mLine) ?? 1, reservesSpace: aLine)
                .font(.body)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(4)
        .textFieldStyle(.roundedBorder)
        
    }
}

struct HInputField: View {
    var title: String
    var placeholder: String
    var mLine: String = "1"
    var aLine: Bool = false
    @Binding var input: String
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                
                Text(title)
                    .font(.callout.lowercaseSmallCaps())
                    .bold()
                
                TextField(
                    placeholder,
                    text: $input,
                    axis: .horizontal
                    
                )
                .lineLimit(Int(mLine) ?? 1, reservesSpace: aLine)
                .font(.body)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(4)
        .textFieldStyle(.roundedBorder)
        
    }
}

struct DateField: View {
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            
            DatePicker(
                "Date of Birth",
                selection: $date,
                displayedComponents: [.date])
            .datePickerStyle(.compact)
            .font(.callout.lowercaseSmallCaps())
            .bold()
            .textInputAutocapitalization(.never)
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(.ultraThinMaterial)
        .cornerRadius(4)
        .fontDesign(.monospaced)
        
    }
}

struct GPSField:View {
    
    
    var title: String
    @Binding var longitude: String
    @Binding var latitude: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.callout)
                .bold()
            
            VStack(alignment: .leading, spacing: 4) {
                
                TextField(
                    "Latitude:\t -122.008889",
                    text: $latitude)
                .font(.body)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .frame(width: UIScreen.main.bounds.width * 0.9)
                
                TextField(
                    "Longitude:\t   37.334722",
                    text: $longitude)
                .font(.body)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .frame(width: UIScreen.main.bounds.width * 0.9)
                
            }
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(4)
        .textFieldStyle(.roundedBorder)
        
    }
}

struct InputFieldLogin: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            InputFieldRequired(
                title: "Email",
                input: $email
            ).keyboardType(.emailAddress)
            
            InputFieldSecure(
                title: "Password",
                input: $password
            )
            
        }.frame(width: UIScreen.main.bounds.width * 0.9)
            .padding(10)
            .background(.ultraThinMaterial)
            .cornerRadius(7)
            .fontDesign(.monospaced)
            .textFieldStyle(.roundedBorder)
    }
    
    
    struct InputFieldRequired: View {
        var title: String
        @Binding var input: String
        
        var body: some View {
            VStack(alignment: .leading) {
                
                Text(title)
                    .font(.callout)
                    .bold()
                
                TextField("",
                          text: $input,
                          prompt: Text("Required"))
                .font(.body)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .frame(width: UIScreen.main.bounds.width * 0.9)
            }
        }
    }
    
    struct InputFieldSecure: View {
        var title: String
        @Binding var input: String
        
        var body: some View {
            
            VStack(alignment: .leading) {
                
                Text(title)
                    .font(.callout)
                    .bold()
                SecureField("",
                            text: $input,
                            prompt: Text("Required"))
                .font(.body)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .frame(width: UIScreen.main.bounds.width * 0.9)
            }
        }
    }
}


struct AccountTemplate_Previews: PreviewProvider {
    static var previews: some View {
        
//        HInputField(
//            title: "Title",
//            placeholder: "Placeholder",
//            mLine: "",
//            aLine: .random(),
//            input: .constant("")
//        ).previewLayout(.sizeThatFits).clipped(antialiased: true)
//    }
            AccountTemplate(
                firstName: .constant("Damian"),
                lastName: .constant("Morning-Star"),
                email: .constant("email@at.com"),
                password: .constant("123456"),
                name: .constant("Morbi a Nam"),
                image: .constant("https://lh5.googleusercontent.com/p/AF1QipO_IVb7Cbn-BcPL-SUU2Krw7munqehxp7J00Dnd=w600-h650-p-k-no"),
                adress: .constant("https://lh5.googleusercontent.com/p/AF1QipO_IVb7Cbn-BcPL-SUU2Krw7munqehxp7J00Dnd=w600-h650-p-k-no"),
                businessHours: .constant("Monday - Friday:\t\t11:00 - 19:00\nSaturday - Sunday:\t12:00 - 17:00"),
                description: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas a mattis ante. Sed pulvinar sollicitudin placerat. Suspendisse potenti. Duis lectus."),
                latitude: .constant(""),
                longtitude: .constant(""),
                isShopAccount: .constant(false),
                date: .constant(.now))
    
        }
}






//        InputField(title: "Title", placeholder: "Something goes here", mLine: "", aLine: true, input: .constant("Body"))

//        DateField(date: .constant(.now))
