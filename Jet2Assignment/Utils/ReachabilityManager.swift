//
//  ReachabilityManager.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit
import ProgressHUD

class ReachabilityManager {
	
	static let shared = ReachabilityManager()
	
	@objc func noInterNetAlert(notification: Notification) {
		if let tabController = TabController.main {
			ProgressHUD.dismiss()
			UIAlertController.show(on: tabController, title: "no_internet_title".localized, message: "no_internet_message".localized)
		}
	}
	
	func startReachbilityObservation() {
		NotificationCenter.default.addObserver(self, selector: #selector(noInterNetAlert(notification:)), name: .ConnectionUnavailable, object: nil)
	}
	
}
