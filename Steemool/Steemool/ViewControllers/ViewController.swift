//
//  ViewController.swift
//  Steemool
//
//  Created by Evgeniy Petlitskiy on 15.06.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let sayingsService: SayingsServiceProtocol
    
    private var sayingsData: [Saying]?
    
    private var currentPage = 0
    
    private lazy var sayingsCollectionViewHeight = 363.VAdapted
    private lazy var sayingsCollectionViewWidth = 250.HAdapted
    
    private lazy var sayingsCollectionViewSideInset = 24.HAdapted
    
    private lazy var sayingsCollectionViewFrameSpacing = (view.bounds.width - sayingsCollectionViewWidth) / 2

    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        var view = UILabel()
        view.backgroundColor = .white
        view.textColor = UIColor(red: 0.639, green: 0.416, blue: 0.98, alpha: 1)
        view.font = UIFont(name: "SFPro-Bold", size: 28)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02

        view.attributedText = NSMutableAttributedString(string: "Steemool", attributes: [NSAttributedString.Key.kern: 0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        return view
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = sayingsCollectionViewSideInset
        
        return layout
    }()
    
    private lazy var sayingsCollectionView: UICollectionView = {
        let sayingsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        sayingsCollectionView.dataSource = self
        sayingsCollectionView.delegate = self
        
        sayingsCollectionView.register(SayingsCollectionViewCell.self,
                                       forCellWithReuseIdentifier: "SayingsCell")
 
        return sayingsCollectionView
    }()
    
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
        
        sayingsService.getAllSayings() { [weak self] data, error in
            self?.sayingsData = data
            self?.sayingsCollectionView.reloadData()
            self?.scrollToTheMiddle()
            
            if let error = error {
                print(error)
            }
        }
        
        setupAppearance()
        addSubviews()
        configureLayout()
    }
    
    // MARK: - Internal methods
    
    func scrollToTheMiddle() {
        guard let sayingsData = sayingsData else { return }
        
        let scrollIndex = sayingsData.count / 2

        self.sayingsCollectionView.reloadData()
        
        DispatchQueue.main.async {
            if scrollIndex < sayingsData.count {
                let indexPath = IndexPath(item: scrollIndex, section: 0)
                self.sayingsCollectionView.scrollToItem(at: indexPath,
                                                        at: UICollectionView.ScrollPosition.centeredHorizontally,
                                                        animated: false)
            }
        }
    }
}

// MARK: - Appearance Methods

private extension ViewController {
    func setupAppearance() {
        view.backgroundColor = .white
        
        sayingsCollectionView.backgroundColor = .clear
        sayingsCollectionView.showsHorizontalScrollIndicator = false
        sayingsCollectionView.decelerationRate = .fast
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(sayingsCollectionView)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(34.VAdapted)
        }
        
        sayingsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24.VAdapted)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(363.VAdapted)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sayingsData = sayingsData else { return 0 }
        
        return sayingsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SayingsCell", for: indexPath) as! SayingsCollectionViewCell
        
        guard let sayingsData = sayingsData else { return cell }
        
        cell.updateData(saying: sayingsData[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sayingsCollectionViewWidth, height: sayingsCollectionViewHeight)
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let sayingsData = sayingsData else { return }
        
        sayingsCollectionView.reloadItems(at: [IndexPath(row: currentPage, section: 0)])

        var pageWidth: CGFloat = 0
        let currentPageWidth = sayingsCollectionViewWidth + sayingsCollectionViewSideInset - sayingsCollectionViewFrameSpacing
        if currentPage != 0 {
            pageWidth = sayingsCollectionViewWidth + sayingsCollectionViewSideInset
        }
        
        var newPage = currentPage

        if velocity.x != 0 {
            newPage = velocity.x > 0 ? currentPage + 1 : currentPage - 1
            if newPage < 0 {
                newPage = sayingsData.count - 1
            }
            if newPage > sayingsData.count - 1 {
                newPage = 0
            }
        }

        currentPage = newPage
        let point = CGPoint (x: CGFloat(newPage - 1) * pageWidth + currentPageWidth, y: 0)
        targetContentOffset.pointee = point
    }
}
