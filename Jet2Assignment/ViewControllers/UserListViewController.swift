//
//  UserListViewController.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 12/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit
import ProgressHUD

class UserListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	let viewModel = UserViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "users".localized
		viewModel.viewDelegate = self
		setupView()
		setupTableView()
		fetch()
		startObservation()
	}
	
	func setupTableView() {
		tableView.rowHeight = UITableView.automaticDimension
	}
	
	func startObservation() {
		NotificationCenter.default.addObserver(forName: .ConnectionAvailable, object: nil, queue: .main) { [weak self] (_) in
			self?.fetch()
		}
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destinationController = segue.destination as? UserProfileViewController,
			let cell = sender as? UserCell, let indexPath = tableView.indexPath(for: cell) {
			let user = viewModel.item(at: indexPath)
			destinationController.user = user
		}
	}
	
	
}

extension UserListViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfItems()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(type: UserCell.self)
		cell?.bind(item: viewModel.item(at: indexPath))
		return cell ?? UITableViewCell()
	}
	
}

extension UserListViewController: ViewProtocol {
	
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
	
	func handleError(_ error: Error?) { }
	
}
