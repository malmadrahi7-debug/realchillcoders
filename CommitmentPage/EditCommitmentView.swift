//
//  EditCommitmentView.swift
//  credibality
//
//  Created by Moria Almadrahi on 12/4/25.
//

import SwiftUI

struct EditCommitmentView: View {
    @Binding var title: String
    var onSave: (String) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Commitment title", text: $title)
            }
            .navigationTitle("Edit Commitment")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
