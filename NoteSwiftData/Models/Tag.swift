//
//  Tag.swift
//  NoteSwiftData
//
//  Created by Volkan Celik on 11/08/2023.
//
import Foundation
import SwiftUI
import SwiftData

@Model
class Tag{
    @Attribute(.unique) var id:String?
    var name:String
    
    @Relationship var notes:[Note]
    @Attribute(.transient) var isChecked=false
    
    init(id: String, name: String, notes: [Note]) {
        self.id = id
        self.name = name
        self.notes = notes
    }
}
