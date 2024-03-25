//
//  Category.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftData

@Model
final class Category: Codable {
    @Attribute(.unique)
    var name: String
    
    var prompts: [Prompt]
    
    init(name: String, prompts: [Prompt]) {
        self.name = name
        self.prompts = prompts
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        prompts = try container.decode([Prompt].self, forKey: .prompts)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(prompts, forKey: .prompts)
    }

    enum CodingKeys: String, CodingKey {
        case name
        case prompts
    }
}
