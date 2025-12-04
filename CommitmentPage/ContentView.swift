//
//  ContentView.swift
//  Credibality
//  Created by Moria Almadrahi on 11/25/25.



import SwiftUI

// MODELS
struct Subtask: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isDone: Bool = false
}

struct Commitment: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var subtasks: [Subtask]

    var progress: Double {
        guard !subtasks.isEmpty else { return 0 }
        let done = subtasks.filter { $0.isDone }.count
        return Double(done) / Double(subtasks.count)
    }
}

enum Section: Hashable {
    case home, commitment, calendar, selfCare
}

enum ActiveSheet: Identifiable {
    case addCommitment
    case editCommitment

    var id: Int { hashValue }
}


// MAIN VIEW

struct ContentView: View {

    @State private var commitments: [Commitment] = []
    @State private var selection: Section = .commitment

    @State private var activeSheet: ActiveSheet?
    @State private var editingCommitmentIndex: Int?
    @State private var editingCommitmentTitle: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                GalaxyBackground()

                switch selection {

                case .home:
                    placeholderPage("Home")

                case .commitment:
                    commitmentPage

                case .calendar:
                    placeholderPage("Calendar")   // simple placeholder

                case .selfCare:
                    placeholderPage("Self Care")
                }
            }
            .safeAreaInset(edge: .bottom) { tabBar }

            .sheet(item: $activeSheet) { sheet in
                switch sheet {

                case .addCommitment:
                    AddCommitmentView(commitments: $commitments)

                case .editCommitment:
                    EditCommitmentView(title: $editingCommitmentTitle) { newTitle in
                        if let idx = editingCommitmentIndex,
                           commitments.indices.contains(idx) {
                            commitments[idx].title = newTitle
                        }
                    }
                }
            }
        }
    }


    // COMMITMENT PAGE


    private var commitmentPage: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {

                RingsView(commitments: commitments)

                HStack {
                    Text("Commitments")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Spacer()

                    Button {
                        activeSheet = .addCommitment
                    } label: {
                        Text("Add +")
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)

                VStack(spacing: 20) {
                    ForEach(commitments.indices, id: \.self) { i in
                        NavigationLink {
                            CommitmentDetailView(commitment: $commitments[i])
                        } label: {
                            CommitmentCard(commitment: commitments[i])
                                .contextMenu {
                                    Button {
                                        editingCommitmentIndex = i
                                        editingCommitmentTitle = commitments[i].title
                                        activeSheet = .editCommitment
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }

                                    Button(role: .destructive) {
                                        commitments.remove(at: i)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }

                Spacer().frame(height: 120)
            }
        }
    }


    // PLACEHOLDER PAGE


    private func placeholderPage(_ title: String) -> some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }


    // TAB BAR


    private var tabBar: some View {
        HStack(spacing: 35) {

            tabItem(icon: "house.fill", text: "Home", tab: .home)

            tabItem(icon: "ring.dashed", text: "Commitments", tab: .commitment)

            tabItem(icon: "calendar", text: "Calendar", tab: .calendar)  // ← ADDED

            tabItem(icon: "person.fill", text: "Self Care", tab: .selfCare)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.black.opacity(0.45))
                .shadow(color: .purple.opacity(0.5), radius: 20, y: -2)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }

    private func tabItem(icon: String, text: String, tab: Section) -> some View {
        Button {
            selection = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .bold))

                Text(text)
                    .font(.caption2)
            }
            .foregroundColor(selection == tab ? .white : .white.opacity(0.6))
            .shadow(color: selection == tab ? .purple.opacity(0.8) : .clear, radius: 10)
        }
        .buttonStyle(.plain)
    }
}


// PREVIEW

#Preview {
    ContentView()
}
