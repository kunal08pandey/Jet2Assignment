//
//  TabController.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

	static var main: TabController? {
		return UIApplication.shared.windows[0].rootViewController as? TabController
	}
	
}
