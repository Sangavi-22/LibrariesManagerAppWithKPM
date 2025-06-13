//
//  ScrollablePageVC.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 12/06/25.
//

import UIKit

class ScrollablePageVC: UIPageViewController {
    
    let firstPage = FirstPageVC()
    let secondPage = SecondPageVC()
    let thirdPage = ThirdPageVC()
    
     let pageControl = UIPageControl()
     var pages: [UIViewController] = []
     var initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        setUpDelegates()
        addPages()
        configureAndAddPageControl()
    }

    func setUpDelegates() {
        dataSource = self
        delegate = self
    }

    func addPages() {
        pages = [firstPage, secondPage, thirdPage]
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }

    func configureAndAddPageControl() {
        view.addSubview(pageControl)

        pageControl.currentPageIndicatorTintColor = .label
        pageControl.pageIndicatorTintColor = .secondaryLabel
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 100),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)])
    }
}

extension ScrollablePageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        return currentIndex == 0 ? pages.last : pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        return currentIndex == pages.count - 1 ? pages.first : pages[currentIndex + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers, let currentIndex = pages.firstIndex(of: viewControllers[0]) else {
            return
        }

        pageControl.currentPage = currentIndex
    }

    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
        return .min
    }
}
