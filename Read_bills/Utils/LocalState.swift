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
        case username
        case First_name
        case Last_name
        case Address
        case PostCode
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
    
    public static var username: String{
        get{
            return UserDefaults.standard.string(forKey: Keys.username.rawValue)!
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.username.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var First_name: String{
        get{
            return UserDefaults.standard.string(forKey: Keys.First_name.rawValue)!
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.First_name.rawValue)
            UserDefaults.standard.synchronize()
        }
    }

    public static var Last_name: String{
        get{
            return UserDefaults.standard.string(forKey: Keys.Last_name.rawValue)!
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.Last_name.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var Address: String{
        get{
            return UserDefaults.standard.string(forKey: Keys.Address.rawValue)!
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.Address.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var PostCode: String{
        get{
            return UserDefaults.standard.string(forKey: Keys.PostCode.rawValue)!
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.PostCode.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
}
