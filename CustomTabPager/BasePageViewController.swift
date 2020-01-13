//
//  BasePageViewController.swift
//  CustomSideMenuBar
//
//  Created by Yuta S. on 2019/05/25.
//  Copyright © 2019 Yuta S. All rights reserved.
//
//


import UIKit

class BasePageViewController: UIPageViewController {
    var itemViewControllers: [UIViewController] = []
    weak var baseViewController: BaseViewController!
    
    var currentPage = 0 {
        willSet {
            self.baseViewController.deselectTab(index: self.currentPage)
        }
        
        didSet {
            self.baseViewController.selectTab(index: self.currentPage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemViewControllers = [ViewController1Builder().build(), ViewController2Builder().build(), ViewController3Builder().build()]
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([itemViewControllers.first!], direction: .forward, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.baseViewController = self.parent as? BaseViewController
    }
    
    func setCurentViewController(index: Int) {
        let direction: NavigationDirection = index > self.currentPage ? .forward : .reverse
        self.currentPage = index
        self.setViewControllers([itemViewControllers[index]], direction: direction, animated: true)
    }
    
    func reload() {
        self.dataSource = nil
        self.dataSource = self
        self.itemViewControllers.removeAll()
        self.itemViewControllers = [ViewController1Builder().build(), ViewController2Builder().build(), ViewController3Builder().build()]
        self.currentPage = 0
        self.setViewControllers([itemViewControllers.first!], direction: .forward, animated: false)
    }
}

extension BasePageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = itemViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if index <= 0 {
            return nil
        }
        
        return itemViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = itemViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if index >= itemViewControllers.count - 1 {
            return nil
        }
        
        return itemViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (!completed) {
            return
        }
        self.currentPage = pageViewController.viewControllers!.first!.view.tag
    }
}

private struct ViewController1Builder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController1")
        ViewController1.view.tag = 0
        return ViewController1
    }
}

private struct ViewController2Builder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController2 = storyboard.instantiateViewController(withIdentifier: "ViewController2")
        ViewController2.view.tag = 1
        return ViewController2
    }
}

private struct ViewController3Builder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController3 = storyboard.instantiateViewController(withIdentifier: "ViewController3")
        ViewController3.view.tag = 2
        return ViewController3
    }
}
