//
//  AddCommitmentView.swift
//  credibality
//
//  Created by Moria Almadrahi on 12/4/25.
//
import SwiftUI

struct AddCommitmentView: View {
    @Binding var commitments: [Commitment]
    @Environment(\.dismiss) var dismiss

    @State private var title = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Commitment title", text: $title)
            }
            .navigationTitle("New Commitment")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        commitments.append(Commitment(title: title, subtasks: []))
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
