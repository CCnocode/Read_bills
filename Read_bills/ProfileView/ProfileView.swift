//
//  ProfileView.swift
//  Read_bills
//
//  Created by chang xing on 11/08/2022.
//  

import Foundation

import SwiftUI

protocol ProfileViewDelegate: AnyObject{
    func didLogout()
}

struct ProfileView: View {
    
    weak var delegate: ProfileViewDelegate?
    
    @State var ChangeProfileImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    
    
    @State private var enableBlogger = true
    
    @State public var First_name: String
    @State public var Last_name: String
    @State public var Address: String
    @State public var PostCode: String
    
    var body: some View {
        NavigationView {
            Form {
                ZStack(alignment: .bottomTrailing){
                Button(action: {
                    ChangeProfileImage = true
                    openCameraRoll = true
                }, label:{
                    if ChangeProfileImage{
                        Image(uiImage: imageSelected)
                            .profileImageMode()
                    }else{
                        Image("London")
                            .profileImageMode()
                    }
                })
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .clipShape(Circle())
                }.sheet(isPresented: $openCameraRoll){
                    ImagePicker(selectedImage: $imageSelected, sourceType:.photoLibrary)
                }
                Section(header: Text("Basic Information")){
                    HStack {
                        Text("First Name")
                        Spacer(minLength: 160)
                        TextField("FirstName", text: $First_name, onEditingChanged: {_ in
                            LocalState.First_name  = self.First_name
                        })
                    }
                    HStack {
                        Text("Last Name")
                        Spacer(minLength: 160)
                        TextField("LastName", text: $Last_name, onEditingChanged: {_ in
                            LocalState.Last_name = self.Last_name
                        })
                    }
                }
                Section(header: Text("Additional")){
                    HStack {
                        Text("Address")
                        Spacer(minLength: 160)
                        TextField("Address", text: $Address, onEditingChanged: {_ in 
                            LocalState.Address  = self.Address
                        })
                    }
                    HStack{
                        Text("Postcode")
                        Spacer(minLength: 150)
                        TextField("PostCode", text: $PostCode, onEditingChanged: {_ in
                            LocalState.PostCode  = self.PostCode
                        })
                    }
                    Toggle(isOn: $enableBlogger) {
                        Text("Login_Status")
                    }
                }
                Section(header: Text("Log Out")){
                    Button(
                        action:{
                            
                            profile_update(Username: LocalState.username, First_name: self.First_name, Last_name: self.Last_name, address: self.Address, postcode: self.PostCode)
                            
                            delegate?.didLogout()
                    },
                    label: {Text("Log Out")}
                    )
                }
            }.navigationBarTitle(Text("Profile"))
        }
    }
}

extension ProfileView{
    func profile_update(Username:String,First_name:String, Last_name:String, address:String, postcode:String){
        let un = Username
        let fn = First_name
        let ln = Last_name
        let ad = address
        let pc = postcode
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8080/Profile_update.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(un)&first_name=\(fn)&last_name=\(ln)&address=\(ad)&postcode=\(pc)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { []
            data, response, error in

            if error != nil {
                print("error=\(String(describing: error))")
                return
            }

            //print("response = \(String(describing: response))")

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString!))")
        }
        task.resume()
    }
}
