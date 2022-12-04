//
//  Me.swift
//  HotProspects
//
//  Created by Justin Wells on 12/4/22.
//

import Foundation

class Me: Codable {
    var name = "Anonymous"
    var emailAddress = "you@yoursite.com"
}

@MainActor class User: ObservableObject {
    @Published var me: Me
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SaveMe")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(Me.self, from: data) {
                self.me = decoded
                return 
            }
        }
        
        me = Me()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(me) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
