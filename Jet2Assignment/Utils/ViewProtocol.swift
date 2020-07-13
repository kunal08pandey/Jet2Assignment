//
//  ViewProtocol.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import Foundation

protocol ViewProtocol: AnyObject {
	typealias Callback = (Bool, Error?) -> Void
	func fetch()
	func showLoader()
	func dismissLoader()
	func reloadData()
	func handleError(_ error: Error?)
}
