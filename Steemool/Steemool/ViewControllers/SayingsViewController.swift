//
//  SayingsViewController.swift
//  Steemool
//
//  Created by Evgeniy Petlitskiy on 15.06.22.
//

import UIKit

class SayingsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let sayingsService: SayingsServiceProtocol
    
    private var sayingsData: [Saying]?
    
    private var currentPage = 0
    
    private lazy var sayingsCollectionViewHeight = 535.VAdapted
    private lazy var sayingsCollectionViewWidth = 317.HAdapted
    
    private lazy var sayingsCollectionViewSideInset = 24.HAdapted
    
    private lazy var sayingsCollectionViewFrameSpacing = (view.bounds.width - sayingsCollectionViewWidth) / 2
    
    private let backgroundImageView = UIImageView(image: UIImage(named: "sayingsViewBackground"))
    
    private let continueButton: LogInButton = {
        let continueButton = LogInButton()
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.makeActive()
        
        return continueButton
    }()

    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "SFPro-Bold", size: CGFloat(28).adaptedFontSize)
        titleLabel.frame = CGRect(x: 0, y: 0, width: 240.HAdapted, height: 68.VAdapted)
        titleLabel.minimumScaleFactor = 0.5
        
        titleLabel.text = "Начни свой день c цитаты!"

        return titleLabel
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
        
        sayingsCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                          left: sayingsCollectionViewSideInset,
                                                          bottom: 0,
                                                          right: sayingsCollectionViewSideInset);
        
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

private extension SayingsViewController {
    func setupAppearance() {
        view.backgroundColor = .white
        
        sayingsCollectionView.backgroundColor = .clear
        sayingsCollectionView.showsHorizontalScrollIndicator = false
        sayingsCollectionView.decelerationRate = .fast
    }
    
    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(sayingsCollectionView)
        view.addSubview(continueButton)
    }
    
    func configureLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(-50.HAdapted)
            make.top.equalToSuperview().offset(-80.VAdapted)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(75.HAdapted)
            make.centerX.equalToSuperview()
        }
        
        sayingsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(22.VAdapted)
            make.bottom.equalToSuperview().offset(-125.VAdapted)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(sayingsCollectionViewHeight)
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16.HAdapted)
            make.bottom.equalToSuperview().offset(-42.VAdapted)
            make.height.equalTo(52.VAdapted)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension SayingsViewController: UICollectionViewDataSource {
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

// MARK: - UICollectionViewDelegateFlowLayout

extension SayingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sayingsCollectionViewWidth, height: sayingsCollectionViewHeight)
    }
}

// MARK: - UICollectionViewDelegate

extension SayingsViewController: UICollectionViewDelegate {
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
