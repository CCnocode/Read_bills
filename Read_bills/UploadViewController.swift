//
//  UploadViewController.swift
//  Read_bills
//
//  Created by chang xing on 16/08/2022.
//

import Foundation
import SwiftUI

struct UploadView: View{
    var body: some View{
        Home()
    }
}

struct Home : View{
    
    @State private var expand = false
    
    var body: some View{
        NavigationView{
            ZStack{
                Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
                ZStack(alignment: .bottomTrailing) {
                    GeometryReader{_ in
                        VStack{
                            Text("Hello")
                        }
                    }
                    VStack(spacing:10){
                        if self.expand{
                            Button(action:{
                                
                            }){
                                Image(systemName: "doc.fill")
                                    .resizable()
                                    .frame(width: 22, height: 20)
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                            
                            Button(action:{
                                
                            }){
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                        }
                        
                        Button(action:{
                            withAnimation(.spring()){
                                self.expand.toggle()
                                
                            }
                            
                        }){
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .background(Color.white)
                        .clipShape(Circle())

                    }
                    .padding()
                }
            }
        }
    }
}
