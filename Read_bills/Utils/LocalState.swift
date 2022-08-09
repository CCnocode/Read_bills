//
//  LocalState.swift
//  Read_bills
//
//  Created by chang xing on 07/08/2022.
//

import Foundation

import UIKit

public class LocalState{
    private enum Keys: String{
        case LoginSuccess
    }
    
    public static var LoginSuccess: Bool{
        get{
            return UserDefaults.standard.bool(forKey: Keys.LoginSuccess.rawValue)
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.LoginSuccess.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
