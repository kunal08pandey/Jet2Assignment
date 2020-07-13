//
//  ArticleViewController.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 11/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit
import Reachability
import ProgressHUD

class ArticleViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView! 
	
	let viewModel = ArticleViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "articles".localized
		setupView()
		viewModel.viewDelegate = self
		setupTableView()
		fetch()
		startObservation()
	}
	
	func setupTableView() {
		tableView.rowHeight = UITableView.automaticDimension
	}
	
	func navigateToUserProfile(_ user: User) {
		let viewController = UIStoryboard.main.viewController(type: UserProfileViewController.self)
		viewController.user = user
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	func startObservation() {
		NotificationCenter.default.addObserver(forName: .ConnectionAvailable, object: nil, queue: .main) { [weak self] (_) in
			self?.fetch()
		}
	}
		
}

extension ArticleViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfItems()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(type: ArticleCell.self)
		cell?.bind(item: viewModel.item(at: indexPath)) { [weak self] user in
			self?.navigateToUserProfile(user as! User)
		}
		return cell ?? UITableViewCell()
	}
	
}

extension ArticleViewController: ViewProtocol {
	func fetch() {
		viewModel.fetch()
	}
	
	func showLoader() {
		ProgressHUD.show()
	}
	
	func dismissLoader() {
		ProgressHUD.dismiss()
	}
	
	func reloadData() {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadData()
			self?.tableView.isHidden = false
		}
	}
	
	func handleError(_ error: Error?) {
		if let error = error {
			UIAlertController.show(on: self, title: "Error", message: error.localizedDescription)
		}
	}
	
}
