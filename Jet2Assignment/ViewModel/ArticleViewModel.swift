//
//  ArticleViewModel.swift
//  Jet2Assignment
//
//  Created by Kunal Pandey on 13/07/20.
//  Copyright © 2020 Kunal Pandey. All rights reserved.
//

import UIKit

class ArticleViewModel: NSObject {	
	let fetcher = ArticleFetcher()
	
	var articles = [Article]()
	
	weak var viewDelegate: ViewProtocol?
	
	func numberOfItems() -> Int {
		return articles.count
	}
	
	func item(at indexPath: IndexPath) -> Article {
		return articles[indexPath.row]
	}
	
	func user(at indexPath: IndexPath) -> User? {
		return articles[indexPath.row].user?.first
	}
	
	func fetch() {
		viewDelegate?.showLoader()
		fetcher.fetch { [weak self] (articles, error) in
			self?.viewDelegate?.dismissLoader()
			if error == nil {
				self?.articles = articles
				self?.viewDelegate?.reloadData()
			} else {
				self?.viewDelegate?.handleError(error)
			}
		}
	}
	
}
