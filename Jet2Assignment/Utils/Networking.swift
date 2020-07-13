//
//  Networking.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 11/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit
import Reachability

enum URLType: String {
	case article = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10"
	case users = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/users?page=1&limit=10"
}

protocol Networking {
	
	typealias CompletionHandler = (Data?, Error?) -> Void
	
	func request(url: URLType, completion: @escaping CompletionHandler)
}

struct HTTPNetworking: Networking {
	let reachability = try? Reachability()
	
	init() {
		try? reachability?.startNotifier()
		reachability?.whenUnreachable = { connection in
			NotificationCenter.default.post(name: .ConnectionUnavailable, object: nil)
		}
		
		reachability?.whenReachable = { connection in
			NotificationCenter.default.post(name: .ConnectionAvailable, object: nil)
		}
	}
	
	func request(url: URLType, completion: @escaping (Data?, Error?) -> Void) {
		guard let request = URL(string: url.rawValue) else { return }
		URLSession.shared.dataTask(with: request) { (data, _, error) in
			completion(data, error)
		}.resume()
	}
	
	
}

