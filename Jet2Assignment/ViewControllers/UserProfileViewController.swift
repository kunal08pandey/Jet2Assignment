//
//  UserProfileViewController.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
	
	@IBOutlet weak var avatarImage: UIImageView!
	@IBOutlet weak var fullNameLabel: UILabel!
	@IBOutlet weak var designationLabel: UILabel!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var aboutLabel: UILabel!
	
	var user: User?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		bind()
	}
	
	func bind() {
		avatarImage.setImage(user?.avatar ?? "")
		fullNameLabel.text = user?.name
		designationLabel.text = user?.designation
		cityLabel.text = user?.city
		aboutLabel.text = user?.about
		avatarImage.makeOval()
	}
	
	
}
