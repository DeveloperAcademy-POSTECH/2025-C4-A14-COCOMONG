//
//  ContentView.swift
//  Beat100
//
//  Created by 이현주 on 7/15/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CprReport.createdAt, ascending: true)],
        animation: .default)
    private var reports: FetchedResults<CprReport>

    var body: some View {
        NavigationView {
            List {
                ForEach(reports) { report in
                    NavigationLink {
                        VStack(alignment: .leading) {
                            Text("Report at \(report.createdAt!, formatter: reportFormatter)")
                            Text("Total Accuracy: \(report.totalAccuracy!.percentage)")
                        }
                    } label: {
                        Text(report.createdAt!, formatter: reportFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { reports[$0] }.forEach(viewContext.delete)

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

private let reportFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
