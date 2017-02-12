//
//  MasterViewController.swift
//  ViewControllerContainment
//
//  Created by Abhijeet Malamkar on 2/12/17.
//  Copyright © 2017 abhijeetmalamkar. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    lazy var summaryViewController:SummaryViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
       var viewController = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var sessionViewController:SessionsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SessionsViewController") as! SessionsViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupView()
    }

    //ABHI: - View Method
    
    private func setupView(){
        setupSegmentedControl()
        updateView()
    }
    
    //ABHIJEET: - updating view
    
    private func updateView(){
        summaryViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        sessionViewController.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)

    }
    
    //ABHIJEET: - setting up segmentcontrol
    
    private func setupSegmentedControl(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Sammary", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Session", at: 1, animated: false)
        
        segmentedControl.addTarget(self, action: #selector(selectionDidCHanged(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0

    }
    
    //ABHIJEET: - action
    
    func selectionDidCHanged(sender:UISegmentedControl) {
        updateView()
    }
    
    //ABHIJEET: - Helper Method
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController){
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    private func removeViewControllerAsChildViewController(childViewController: UIViewController){
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
    
}

