//
//  Extensions.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit
import Kingfisher

protocol CellProtocol {
	associatedtype Item;
	associatedtype Object;
	typealias ActionCallBack = (Object) -> Void
	func bind(item: Item, _ onUserClick: ActionCallBack?)
}


extension UITableView {
	
	func dequeueCell<T: UITableViewCell>(type: T.Type) -> T? {
		dequeueReusableCell(withIdentifier: "\(T.self)") as? T
	}
	
}

extension UITableViewCell: CellProtocol {
	
	typealias Item = Any
	typealias Object = Any
	
	func bind(item: Item, _ onUserClick: ActionCallBack? = nil) { fatalError("Must Override this method") }
	
}

extension UIImageView {
	
	func setImage(_ urlString: String) {
		guard let url = URL(string: urlString) else { return }
		setImage(url)
	}
	
	func setImage(_ url: URL) {
		let imageResource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
		self.kf.setImage(with: imageResource) { [weak self] (result) in
			switch result {
				case .success(let imageResult):
					self?.image = imageResult.image
				case .failure(_):
					self?.image = UIImage(named: "article_placeholder")
			}
		}
	}
	
	func makeOval() {
		layer.cornerRadius = self.bounds.width / 2
		layer.masksToBounds = true
	}
	
}

extension Int {
	
	var stringValue: String {
		if self > 1000000 {
			return "\(self/1000)M"
		}
		else if self > 1000 {
			return "\(self/1000)K"
		} else {
			return "\(self)"
		}
	}
}

extension TimeInterval {
	
	var time: String {
		let timeinseconds = abs(self/1000)
		if timeinseconds > 86400 * 30 {
			return  String(format: "%2.0f months", (timeinseconds / (86400 * 30)))
		} else if timeinseconds > 86400 {
			return  String(format: "%2.0f days", (timeinseconds / 86400))
		} else if timeinseconds > 3600 {
			return  String(format: "%2.0f hrs", (timeinseconds / 3600))
		} else if timeinseconds > 60 {
			return  String(format: "%2.0f mins", (timeinseconds / 60))
		} else {
			return  String(format: "%2.0f sec", timeinseconds)
		}
	}
}

extension String {
	
	var localized: String {
		return NSLocalizedString(self, comment: "")
	}
	
}

extension DateFormatter {
	static let iso8601Full: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter
	}()
}

extension Date {
	
	static var now: Date {
		return Date()
	}
	
	var time: String {
		let timeInterval = self.timeIntervalSinceNow
		return timeInterval.time
	}
	
}

extension UIStoryboard {
	
	static var main: UIStoryboard {
		return UIStoryboard(name: "Main", bundle: nil)
	}
	
	func viewController<T: UIViewController>(type: T.Type) -> T {
		return self.instantiateViewController(withIdentifier: "\(type)") as! T
	}
	
}

extension UIButton {
	
	func linkActivate() {
		addTarget(self, action: #selector(performClick), for: .touchDragInside)
	}
	
	@objc func performClick() {
		if let urlString = titleLabel?.text, let url = URL(string: urlString) {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
	}
	
}

extension UIViewController {
	
	func setupView() {
		navigationController?.navigationBar.tintColor = .black
		tabBarController?.tabBar.tintColor = .black
	}
	
}

extension UIAlertController {
	
	static func show(on vc: UIViewController, title: String, message: String) {
		let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
		controller.addAction(alertAction)
		vc.show(controller, sender: nil)
	}
	
}

extension Notification.Name {
	
	static var ConnectionUnavailable: Notification.Name {
		return Notification.Name("ConnectionUnavailable")
	}
	
	static var ConnectionAvailable: Notification.Name {
		return Notification.Name("ConnectionAvailable")
	}
	
}

