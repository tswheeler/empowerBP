//
//  Configs.swift
//  EmpowerBP
//
//  Created by Tyler S Wheeler on 2017-07-11.
//  Copyright © 2017 Tyler S Wheeler. All rights reserved.
//

import Foundation
import UIKit





// HUD View
let hudView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
extension UIViewController {
    func showHUD() {
        hudView.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        hudView.backgroundColor = UIColor.darkGray
        hudView.alpha = 0.9
        hudView.layer.cornerRadius = hudView.bounds.size.width/2
        
        indicatorView.center = CGPoint(x: hudView.frame.size.width/2, y: hudView.frame.size.height/2)
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        hudView.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.addSubview(hudView)
    }
    func hideHUD() { hudView.removeFromSuperview() }
    func simpleAlert(_ mess:String) {
        UIAlertView(title: "empowerBP", message: mess, delegate: nil, cancelButtonTitle: "OK").show()
    }
}


//Back4App

/* USER CLASS */
let USER_CLASS_NAME = "User"
let USER_ID = "objectId"
let USER_USERNAME = "username"
let USER_FULLNAME = "fullName"
let USER_PHONE = "phone"
let USER_EMAIL = "email"
let USER_WEBSITE = "website"
let USER_AVATAR = "avatar"

/* INTERVENTION CLASS */
let INT_CLASS_NAME = "Interventions"
let INT_ID = "objectId"
let INT_CODE = "interventionName"
let INT_RESOURCE_TITLE = "resourceName"
let INT_SOURCE = "source"
let INT_TEXT = "homeworkText"
let INT_GOAL = "appropriateForGoal"

/* FAVORITES CLASS */
let FAV_CLASS_NAME = "Favorites"
let FAV_USERNAME = "username"
let FAV_USER_POINTER = "userPointer"
let FAV_AD_POINTER = "adPointer" // Pointer
