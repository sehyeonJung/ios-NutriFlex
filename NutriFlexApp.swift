//
//  NutriFlexApp.swift
//  NutriFlex
//
//  Created by carolyn on 7/5/2024.
//

import SwiftUI
import FirebaseCore

@main
struct NutriFlexApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    @StateObject var vm : cddatamodel = cddatamodel()
    var body: some Scene {
        
        WindowGroup {
            StartingPage()
                .environmentObject(cddatamodel())
            }
        }
    }

//import SwiftUI
//import FirebaseCore
//
//@main
//struct SwiftUI_AuthApp: App {
//    
//    init() {
//        FirebaseApp.configure()
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

