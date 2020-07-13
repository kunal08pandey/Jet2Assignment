//
//  Fetcher.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 12/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import Foundation

struct User : Codable {
	let id : String?
	let blogId : String?
	let createdAt : Date?
	let name : String?
	let avatar : String?
	let lastname : String?
	let city : String?
	let designation : String?
	let about : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case blogId = "blogId"
		case createdAt = "createdAt"
		case name = "name"
		case avatar = "avatar"
		case lastname = "lastname"
		case city = "city"
		case designation = "designation"
		case about = "about"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		blogId = try values.decodeIfPresent(String.self, forKey: .blogId)
		createdAt = try values.decodeIfPresent(Date.self, forKey: .createdAt)
		name = try values.decodeIfPresent(String.self, forKey: .name)?.capitalized
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
		lastname = try values.decodeIfPresent(String.self, forKey: .lastname)?.capitalized
		city = try values.decodeIfPresent(String.self, forKey: .city)?.capitalized
		designation = try values.decodeIfPresent(String.self, forKey: .designation)?.capitalized
		about = try values.decodeIfPresent(String.self, forKey: .about)?.capitalized
	}

}
