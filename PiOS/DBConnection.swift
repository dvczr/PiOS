//
//  DBConnection.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-25.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class DatabaseConnection: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    @Published var shopList = [Shop]()
    @Published var userList = [UserAcct]()
    
    private var usersCollection = "Users"
    private var userListener: ListenerRegistration?
    private var shopsCollection = "Shops"
    private var shopListener: ListenerRegistration?
    
    
    init() {
        
        Auth.auth().addStateDidChangeListener() {
            auth, user in
            
            if let user = user {
                self.userLoggedIn = true
                self.currentUser = user
                self.addSnapshotListenerToUser()
                self.addSnapshotListenerToShop()
                
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
                self.removeSnapshotListenerToShop()
            }
            //            self.addSnapshotListenerToShop()
        }
    }
    
    func CheckUser(user: UserAcct ) -> Bool {
        
        if let currentUser = Auth.auth().currentUser?.uid {
            if user.id == currentUser {
                print("OK checked User >\tID:\(user.id)\n\t\t\t\t   cID:\(currentUser)")
                return true
            }
        }
        
        return false
        
    }
    
    func Login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            authDataResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func CreateUserAccount(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        isUserAccount: Bool) {
            Auth.auth().createUser(withEmail: email, password: password) {
                authDataResult, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let authDataResult = authDataResult {
                    if isUserAccount {
                        let newUser = UserAcct(
                            id: authDataResult.user.uid,
                            nameFirst: firstName,
                            nameLast: lastName,
                            email: email)
                        do {
                            _ = try self.db.collection(self.usersCollection)
                                .document(authDataResult.user.uid)
                                .setData(from: newUser)
                            print("Succesfully Created A New User Account")
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    
    func CreateShopAccount(
        email: String,
        password: String,
        name: String,
        image: String,
        adress: String,
        businessHours: String,
        description: String,
        latitude: String,
        longitude: String,
        isShopAccount: Bool) {
            Auth.auth().createUser(withEmail: email, password: password) {
                authDataResult, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let authDataResult = authDataResult {
                    if !isShopAccount {
                        let newShop = Shop(
                            id: authDataResult.user.uid,
                            name: name,
                            image: image,
                            adress: adress,
                            businessHours: businessHours,
                            description: description,
                            latitude: latitude,
                            longitude: longitude)
                        do {
                            _ = try self.db.collection(self.shopsCollection)
                                .document(authDataResult.user.uid)
                                .setData(from: newShop)
                            print("Succesfully Created A New Shop Account")
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    
    
    
    func LogOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("An Error has ocurred while login out")
        }
    }
    
    func addSnapshotListenerToUser() {
        userListener = db.collection(usersCollection).addSnapshotListener {
            snapshot, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let snapshot = snapshot else {
                print("Error retrieving user")
                return
            }
            self.userList = []
            
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: UserAcct.self)
                }
                switch result {
                case .success(let user):
                    self.userList.append(user)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    func removeSnapshotListenerToUser() {
        if let userListener = userListener {
            userListener.remove()
        }
    }
    
    func addSnapshotListenerToShop() {
        shopListener = db.collection(shopsCollection).addSnapshotListener {
            snapshot, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let snapshot = snapshot else {
                print("Error retrieving vapeshop")
                return
            }
            self.shopList = []
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: Shop.self)
                    
                }
                switch result {
                case .success(let shop):
                    self.shopList.append(shop)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    func removeSnapshotListenerToShop() {
        if let shopListener = shopListener {
            shopListener.remove()
        }
    }
    
    //    func addCommentToDb(vapeshopId: String, comment: Comment) {
    //        do {
    //            try db.collection(vapeshopCollection).document(vapeshopId).updateData(["comments":FieldValue.arrayUnion([Firestore.Encoder().encode(comment)])])
    //        } catch {
    //            print("\t\t\t! O B S ¡\n\taddCommentToDb\n\t H A S   F U C K E D   U P")
    //        }
    //    }
}

