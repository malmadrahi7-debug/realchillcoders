//
//  CommitmentDetailView..swift
//  credibality
//
//  Created by Moria Almadrahi on 12/4/25.
//

import SwiftUI

struct CommitmentDetailView: View {
    @Binding var commitment: Commitment

    @State private var showAddSubtask = false
    @State private var showEditSubtask = false
    @State private var editingSubtaskIndex: Int?
    @State private var editedSubtaskTitle: String = ""

    var body: some View {
        ZStack {
            GalaxyBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {

                    HStack {
                        Text(commitment.title)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)

                        Spacer()

                        ProgressRing(progress: commitment.progress, color: .white, size: 70)
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)

                    VStack(spacing: 25) {
                        ForEach(commitment.subtasks.indices, id: \.self) { i in
                            subtaskRow(i)
                        }
                    }

                    Button {
                        showAddSubtask = true
                    } label: {
                        Text("➕ Add Subtask")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.75))
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                    .sheet(isPresented: $showAddSubtask) {
                        AddSubtaskView(commitment: $commitment)
                    }
                    .sheet(isPresented: $showEditSubtask) {
                        EditSubtaskView(title: $editedSubtaskTitle) { newTitle in
                            if let n = editingSubtaskIndex {
                                commitment.subtasks[n].title = newTitle
                            }
                        }
                    }

                    Spacer().frame(height: 120)
                }
            }
        }
    }

    private func subtaskRow(_ i: Int) -> some View {
        HStack(spacing: 15) {

            VStack {
                Circle()
                    .fill(commitment.subtasks[i].isDone ? .green : .red)
                    .frame(width: 12, height: 12)

                if i < commitment.subtasks.count - 1 {
                    Rectangle()
                        .fill(Color.white.opacity(0.4))
                        .frame(width: 2, height: 40)
                }
            }

            HStack(spacing: 12) {
                Text(commitment.subtasks[i].title)
                    .foregroundColor(.white)

                Spacer()

                Button { commitment.subtasks[i].isDone.toggle() } label: {
                    Circle()
                        .stroke(.white, lineWidth: 3)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Circle()
                                .fill(commitment.subtasks[i].isDone ? .green : .clear)
                                .frame(width: 18, height: 18)
                        )
                }

                Button {
                    editingSubtaskIndex = i
                    editedSubtaskTitle = commitment.subtasks[i].title
                    showEditSubtask = true
                } label: {
                    Image(systemName: "pencil").foregroundColor(.white)
                }

                Button {
                    commitment.subtasks.remove(at: i)
                } label: {
                    Image(systemName: "trash").foregroundColor(.red)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white.opacity(0.06))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.green, lineWidth: 2)
                    )
            )
        }
        .padding(.horizontal)
    }
}
