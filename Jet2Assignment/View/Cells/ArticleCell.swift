//
//  ArticleCell.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var designationLabel: UILabel!
	@IBOutlet weak var avatarImageView: UIImageView!
	
	@IBOutlet weak var articleContentLabel: UILabel!
	@IBOutlet weak var articleImageView: UIImageView!
	@IBOutlet weak var articleTitleLabel: UILabel!
	@IBOutlet weak var articleUrlLabel: UIButton!
	
	@IBOutlet weak var likesLabel: UILabel!
	@IBOutlet weak var commentsLabel: UILabel!
	
	@IBOutlet weak var userView: UIView!
	
	lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureClicked))
	
	typealias Item = Article
	typealias Object = User
	
	var user: User?
	var onUserClick: ActionCallBack?
	
	override func layoutSubviews() {
		super.layoutSubviews()
		avatarImageView.makeOval()
	}
	
	func bind(item: Article, _ onUserClick: @escaping ActionCallBack) {
		if let user = item.user?.first {
			nameLabel.text = user.name
			designationLabel.text = user.designation
			avatarImageView.setImage(user.avatar ?? "")
			timeLabel.text = user.createdAt?.time
			self.user = user
		}
		self.onUserClick = onUserClick
		articleImageView.setImage(item.media?.first?.image ?? "")
		articleContentLabel.text = item.content
		articleTitleLabel.text = item.media?.first?.title?.capitalized
		articleUrlLabel.setTitle(item.media?.first?.url, for: .normal)
		articleUrlLabel.linkActivate()
		
		likesLabel.text = item.likesString
		commentsLabel.text = item.commentsString
		userView.addGestureRecognizer(tapGesture)
	}
	
	@objc func tapGestureClicked() {
		if let user = self.user {
			onUserClick?(user)
		}
	}
	
}
