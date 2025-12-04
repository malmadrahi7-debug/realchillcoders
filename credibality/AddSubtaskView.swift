//
//  AddSubtaskView.swift
//  credibality
//
//  Created by Moria Almadrahi on 12/4/25.
//

import SwiftUI

struct AddSubtaskView: View {
    @Binding var commitment: Commitment
    @Environment(\.dismiss) var dismiss

    @State private var title = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Subtask name", text: $title)
            }
            .navigationTitle("New Subtask")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        commitment.subtasks.append(Subtask(title: title))
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
