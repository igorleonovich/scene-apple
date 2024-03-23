//
//  Router.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 23/03/2024.
//

import Foundation

final class Router {
    
    static var currentPath = "/"
    
    static func go(to pathToGo: String) {
        print("[ROUTER] Go to:\n\(pathToGo)")
    }
}
