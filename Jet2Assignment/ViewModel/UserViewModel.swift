//
//  UserViewModel.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit

class UserViewModel: NSObject {
	
	let fetcher = UsersFetcher()
	
	var users = [User]()
	
	weak var viewDelegate: ViewProtocol?
	
	func numberOfItems() -> Int {
		return users.count
	}
	
	func item(at indexPath: IndexPath) -> User {
		return users[indexPath.row]
	}
	
	func fetch() {
		viewDelegate?.showLoader()
		fetcher.fetch { [weak self] (users, error) in
			self?.viewDelegate?.dismissLoader()
			if error == nil {
				self?.users = users
				self?.viewDelegate?.reloadData()
			} else {
				self?.viewDelegate?.handleError(error)
			}
		}
	}
	
}
