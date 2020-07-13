//
//  Fetcher.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 12/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import Foundation

struct Article : Codable {
	let id : String?
	let createdAt : Date?
	let content : String?
	let comments : Int?
	let likes : Int?
	let media : [Media]?
	let user : [User]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case createdAt = "createdAt"
		case content = "content"
		case comments = "comments"
		case likes = "likes"
		case media = "media"
		case user = "user"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		createdAt = try values.decodeIfPresent(Date.self, forKey: .createdAt)
		content = try values.decodeIfPresent(String.self, forKey: .content)?.capitalized
		comments = try values.decodeIfPresent(Int.self, forKey: .comments)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		media = try values.decodeIfPresent([Media].self, forKey: .media)
		user = try values.decodeIfPresent([User].self, forKey: .user)
	}
}

extension Article {
	
	var likesString: String {
		if let likes = self.likes {
			return likes.stringValue + "likes".localized
		}
		return 0.stringValue + "likes".localized
	}
	
	var commentsString: String {
		if let comments = self.comments {
			return comments.stringValue + "comments".localized
		}
		return 0.stringValue + "comments".localized
	}
}
