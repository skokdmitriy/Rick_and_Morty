//
//  DetailViewController.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 19.08.2023.
//

import UIKit
import SwiftUI

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeDetailView()
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }

    private func makeDetailView() {
        let detailView = DetailView().environmentObject(viewModel)
        let controller = UIHostingController(rootView: detailView)
        addChild(controller)
        controller.didMove(toParent: self)

        view.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
