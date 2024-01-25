//
//  Person.swift
//  Designs4u
//
//  Created by Arpit Srivastava on 23/01/24.
//

import Foundation

struct Person: Decodable, Identifiable, Comparable {
    let id: Int
    let photo, thumbnail: URL
    let firstName, lastName, email: String
    let experience, rate: Int
    let bio, details: String
    let skills: Set<Skill>
    let tags: [String]

    var displayName: String {
        let components = PersonNameComponents(givenName: firstName, familyName: lastName)
        return components.formatted()
    }

    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.lastName < rhs.lastName
    }

    static let example = Person(id: 1,
                                photo: URL(string: "https://hws.dev/img/user-1-full.jpg")!,
                                thumbnail: URL(string: "https://hws.dev/user-1-thumb.jpg")!,
                                firstName: "Jaime",
                                lastName: "Rove",
                                email: "jrove1@huffingtonpost.com",
                                experience: 10,
                                rate: 300,
                                bio: "A few lines about this person go here.",
                                details: "A couple more sentences about this person go here.",
                                skills: [Skill(id: "Illustrator"), Skill(id: "Photoshop")],
                                tags: ["ideator", "aligned", "manager", "excitable"])

}

struct Skill: Hashable, Decodable, Comparable, Identifiable {

    let id: String

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.id = try container.decode(String.self)
    }

    init(id: String) {
        self.id = id
    }

    static func <(lhs: Skill, rhs: Skill) -> Bool {
        lhs.id < rhs.id
    }
}
