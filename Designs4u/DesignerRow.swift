//
//  DesignerRow.swift
//  Designs4u
//
//  Created by Arpit Srivastava on 23/01/24.
//

import SwiftUI

struct DesignerRow: View {

    @ObservedObject var model: DataModel
    var person: Person
    var namespace: Namespace.ID
    @Binding var selectedPerson: Person?

    var body: some View {
        HStack {
            Button {
                guard model.selected.count < 5 else { return }
                withAnimation {
                    model.select(person)
                }
            } label: {
                HStack {
                    AsyncImage(url: person.thumbnail, scale: 3)
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .matchedGeometryEffect(id: person.id, in: namespace)

                    VStack(alignment: .leading) {
                        Text(person.displayName)
                            .font(.headline)

                        Text(person.bio)
                            .multilineTextAlignment(.leading)
                            .font(.caption)
                    }
                }
            }
            .tint(.primary)

            Spacer()

            Button {
                selectedPerson = person
            } label: {
                Image(systemName: "info.circle")
            }
            .buttonStyle(.borderless)
        }
    }
}

#Preview {
    @Namespace var namespace
    return DesignerRow(model: DataModel(), person: .example, namespace: namespace, selectedPerson: .constant(nil))
}
