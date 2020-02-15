//
//  SwipeMenuViewController.swift
//  SwipeMenuViewControllerTP
//
//  Created by zizi4n5 on 2020/02/15.
//  Copyright © 2020 zizi4n5. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class SwipeMenuViewTestController: UIViewController {

    private let menuTitles = ["Menu1", "Menu2", "Menu3", "Menu4"]

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var swipeMenuView: SwipeMenuView!

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        swipeMenuView.reloadData()
    }
}

extension SwipeMenuViewTestController: SwipeMenuViewDelegate {

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        switch toIndex {
        case 0:
            UIView.animate(withDuration: swipeMenuView.options.tabView.additionView.animationDuration, delay: 0.0, animations: { [view, searchBar, swipeMenuView] in
                guard let view = view, let searchBar = searchBar else { return }
                searchBar.frame.origin.y = view.safeAreaInsets.top
                searchBar.alpha = 1.0
                swipeMenuView.frame.size.height = view.frame.height - view.safeAreaInsets.top - searchBar.frame.height
                swipeMenuView.frame.origin.y = searchBar.frame.height + view.safeAreaInsets.top
            })
        default:
            searchBar.endEditing(true)
            UIView.animate(withDuration: swipeMenuView.options.tabView.additionView.animationDuration, delay: 0.0, animations: { [view, searchBar, swipeMenuView] in
                guard let view = view, let searchBar = searchBar else { return }
                searchBar.frame.origin.y = view.safeAreaInsets.top - searchBar.frame.height
                searchBar.alpha = 0.0
                swipeMenuView.frame.size.height = view.frame.height - view.safeAreaInsets.top
                swipeMenuView.frame.origin.y = view.safeAreaInsets.top
            })
        }
    }
}

extension SwipeMenuViewTestController: SwipeMenuViewDataSource {

    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return menuTitles.count
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return menuTitles[index]
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        return UIViewController()
    }
}
