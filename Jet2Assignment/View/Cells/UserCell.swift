//
//  UserCell.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
	
	@IBOutlet weak var avatarImage: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var designationLabel: UILabel!
	@IBOutlet weak var cityLabel: UILabel!
	
	typealias Item = User
	
	override func layoutSubviews() {
		super.layoutSubviews()
		avatarImage.makeOval()
	}
	
	func bind(item: User, _ onUserClick: ((Any) -> Void)? = nil) {
		avatarImage.setImage(item.avatar ?? "")
		nameLabel.text = item.name
		designationLabel.text = item.designation
		cityLabel.text = item.city
	}
}
