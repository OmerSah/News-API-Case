//
//  BookmarksViewController.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 13.07.2022.
//

import UIKit
import SafariServices

class BookmarksViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(BookmarksCell.self, forCellReuseIdentifier: Constants.UI.bookmarksCellID)
        table.rowHeight = 200
        return table
    }()
    
    private let viewModel: BookmarksViewModel
    
    init(viewModel: BookmarksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "BOOKMARKS_VIEW_CONTROLLER_TITLE".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func configure() {
        view.addSubview(tableView)
        
        tableView.pin(to: view)
    }

}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.UI.bookmarksCellID) as? BookmarksCell
        else {
            return UITableViewCell()
        }
        
        cell.setArticle(article: viewModel.news[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: viewModel.news[indexPath.row].url ?? "") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteBookmarkedArticle(article: viewModel.news[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension BookmarksViewController: BookmarksOutput {
    
    func refresh() {
        tableView.reloadData()
    }
    
}
