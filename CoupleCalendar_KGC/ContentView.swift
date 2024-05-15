//
//  ContentView.swift
//  CoupleCalendar_KGC
//
//  Created by KYUCHEOL KIM on 5/14/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    ///CoreData의 관리 객체 컨텍스트를 가져옵니다. 이 컨텍스트를 사용하여 CoreData의 데이터를 관리합니다.
    @Environment(\.managedObjectContext) private var viewContext

    ///CoreData에서 데이터를 가져오기 위한 속성입니다. Item 엔터티를 기준으로 정렬된 데이터를 가져옵니다.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
    
    ///데이터를 추가하는 메서드입니다. CoreData에 새로운 Item 객체를 추가하고, 관리 객체 컨텍스트를 저장합니다.
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    ///데이터를 삭제하는 메서드입니다. 선택된 인덱스에 해당하는 아이템을 CoreData에서 삭제하고, 관리 객체 컨텍스트를 저장합니다.
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

///SwiftUI 뷰의 미리보기를 정의합니다. PersistenceController.preview.container.viewContext를 환경에 제공하여 CoreData의 미리보기용 컨텍스트를 사용합니다.
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
