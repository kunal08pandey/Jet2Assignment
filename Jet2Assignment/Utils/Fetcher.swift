//
//  Fetcher.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 12/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import Foundation

protocol Fetcher {
	associatedtype ResponseType
	typealias Completion = (ResponseType, Error?) -> Void
	func fetch(completion:  @escaping Completion)
}

struct ArticleFetcher: Fetcher {
	
	let networking = HTTPNetworking()
	
	typealias ResponseType = [Article]
	
	func fetch(completion: @escaping (ResponseType, Error?) -> Void) {
		networking.request(url: .article) { (data, error) in
			let jsonDecoder = JSONDecoder()
			jsonDecoder.dateDecodingStrategy = .formatted(.iso8601Full)
			guard let data = data,
				let response = try? jsonDecoder.decode(ResponseType.self, from: data) else { return }
			completion(response, error)
		}
	}
	
}

struct UsersFetcher: Fetcher {
	let networking = HTTPNetworking()
	
	typealias ResponseType = [User]
	
	func fetch(completion: @escaping (ResponseType, Error?) -> Void) {
		networking.request(url: .users) { (data, error) in
			let jsonDecoder = JSONDecoder()
			jsonDecoder.dateDecodingStrategy = .formatted(.iso8601Full)
			guard let data = data,
				let response = try? jsonDecoder.decode(ResponseType.self, from: data) else { return }
			completion(response, error)
		}
	}
}
