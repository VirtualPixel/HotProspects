//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Justin Wells on 12/4/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
