//
//  NewsListViewController.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 8.07.2022.
//

import UIKit
import SafariServices

class NewsListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(NewsListCell.self, forCellReuseIdentifier: Constants.UI.newsListCellID)
        table.rowHeight = 200
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "SEARCH_BAR_PLACEHOLDER".localized
        definesPresentationContext = true
        return searchController
    }()
    
    private let viewModel: NewsListViewModel
    
    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "NEWS_LIST_VIEW_CONTROLLER_TITLE".localized
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func configure() {
        view.addSubview(tableView)
        
        navigationItem.searchController = searchController
        
        tableView.pin(to: view)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"),
                        style: .plain,
                        target: self, action: #selector(filterButtonAction))
    }
    
    @objc func pullToRefresh() {
        viewModel.refreshData(filterStaus: isFiltering)
    }
    
    @objc func filterButtonAction() {
        let vc = FilterViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        vc.filterButtonAction = { [weak self] from, to in
            guard let self = self else { return }
            self.viewModel.filterNewsByRange(from: from, to: to)
        }
        
        vc.navigationItem.title = "FILTER_VIEW_CONTROLLER_TITLE".localized
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [ .medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        present(nav, animated: true)
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: Constants.UI.newsListCellID,
                    for: indexPath) as? NewsListCell
        else { return NewsListCell() }
        
        cell.setArticle(article: viewModel.news[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detail = NewsDetailViewController()
        detail.setArticle(article: viewModel.news[indexPath.row])
        detail.bookmarkAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.bookmarkButtonAction(article: self.viewModel.news[indexPath.row])
        }
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension NewsListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.searchNews(query: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchNews()
        viewModel.queryForDateRange = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true)
        let searchBar = searchController.searchBar
        viewModel.queryForDateRange = searchBar.text ?? ""
    }
}

extension NewsListViewController {
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text!.isEmpty
    }
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
}

extension NewsListViewController: NewsListOutput {
    func endTableRefresh() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func showError(error: NetworkError) {
        let alert =
        UIAlertController(
            title: "Operation Failed!",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
                                           
        present(alert, animated: true, completion: nil)
    }
    
    func refresh() {
        tableView.reloadData()
    }
}

