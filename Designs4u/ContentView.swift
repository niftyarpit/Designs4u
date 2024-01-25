//
//  ContentView.swift
//  Designs4u
//
//  Created by Arpit Srivastava on 23/01/24.
//

import SwiftUI

struct ContentView: View {

    @StateObject var dataModel = DataModel()
    @Namespace var namespace
    @State private var selectedDesigner: Person?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(dataModel.searchResults) { person in
                        DesignerRow(model: dataModel, person: person, namespace: namespace, selectedPerson: $selectedDesigner)
                    }
                }
                .padding(.horizontal)
            }
            .safeAreaInset(edge: .bottom) {
                if dataModel.selected.isEmpty == false {
                    VStack {
                        HStack(spacing: -10) {
                            ForEach(dataModel.selected) { person in
                                Button {
                                    withAnimation {
                                        dataModel.remove(person)
                                    }
                                } label: {
                                    AsyncImage(url: person.thumbnail, scale: 3)
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: 2)
                                        )
                                }
                                .buttonStyle(.plain)
                                .matchedGeometryEffect(id: person.id, in: namespace)
                            }
                        }

                        NavigationLink {
                            // go to the next screen
                        } label: {
                            Text("Select ^[\(dataModel.selected.count) Person](inflect: true)")
                                .frame(maxWidth: .infinity, minHeight: 44)
                        }
                        .buttonStyle(.borderedProminent)
                        .contentTransition(.identity)
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal, .top])
                    .background(.ultraThinMaterial)
                }

            }
            .navigationTitle("Designs4u")
        }
        .searchable(text: $dataModel.searchText, tokens: $dataModel.tokens, suggestedTokens: dataModel.suggestedTokens, prompt: Text("Search, or use # to select skills")) { token in
            Text(token.id)
        }
        .task {
            do {
                try await dataModel.fetch()
            } catch {
                print("Handle errors")
            }
        }
        .sheet(item: $selectedDesigner, content: DesignerDetails.init)
    }
}

#Preview {
    ContentView()
}
