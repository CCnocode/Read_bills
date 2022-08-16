//
//  ProfileImageMode.swift
//  Read_bills
//
//  Created by chang xing on 15/08/2022.
//

import Foundation
import SwiftUI

extension Image{
    func profileImageMode() -> some View{
        self
            .resizable()
            .clipped()
            .frame(width: 100, height: 100, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.blue, lineWidth: 2.0))
    }
}
