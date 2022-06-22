//
//  ViewController.swift
//  Steemool
//
//  Created by Evgeniy Petlitskiy on 15.06.22.
//

import UIKit

class ViewController: UIViewController {
    
    private let sayingsService: SayingsServiceProtocol
    
    // MARK: - Initialization and deinitialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        sayingsService = SayingsService()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

