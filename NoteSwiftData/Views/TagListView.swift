//
//  TagListView.swift
//  NoteSwiftData
//
//  Created by Volkan Celik on 11/08/2023.
//

import SwiftUI
import SwiftData

struct TagListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Tag.name,order: .forward) var allTags:[Tag]
    @State var tagText=""
    
    var body: some View {
        List{
            Section{
                DisclosureGroup("Create a tag") {
                    TextField("Enter text", text: $tagText,axis: .vertical)
                        .lineLimit(2...4)
                    Button("Save"){
                        createTag()
                    }
                    .disabled(tagText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            
            Section{
                if allTags.isEmpty{
                    ContentUnavailableView("You don't have any tags yet", systemImage: "tag")
                }else{
                    ForEach(allTags){tag in
                        if tag.notes.count>0{
                            DisclosureGroup("\(tag.name) (\(tag.notes.count))") {
                                ForEach(tag.notes){note in
                                    Text(note.content)
                                }
                                .onDelete(perform: { indexSet in
                                    indexSet.forEach { index in
                                        context.delete(tag.notes[index])
                                    }
                                    try? context.save()
                                })
                            }
                        }
                        else{
                            Text(tag.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            context.delete(allTags[index])
                        }
                        try? context.save()
                    })
                }
            }
        }
    }
    
    func createTag(){
        let tag=Tag(id: UUID().uuidString, name: tagText, notes: [])
        context.insert(tag)
        try? context.save()
        tagText=""
    }
    
}

#Preview {
    TagListView()
}
