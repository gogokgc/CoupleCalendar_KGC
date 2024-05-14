//
//  CoupleCalendar_KGCApp.swift
//  CoupleCalendar_KGC
//
//  Created by KYUCHEOL KIM on 5/14/24.
//

import SwiftUI

@main
struct CoupleCalendar_KGCApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
