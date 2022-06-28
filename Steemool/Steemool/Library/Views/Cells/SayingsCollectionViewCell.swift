//
//  SayingsCollectionViewCell.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit
import SnapKit

final class SayingsCollectionViewCell: UICollectionViewCell {
    
    static let id = "SayingsCell"
    
    private var sayingsLayerView = UIView()
    
    private var sayingsImageView = UIImageView()
    private var sayingsTextLabel = UILabel()
    private var sayingsAuthorLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    private func configureCell() {
        setupAppearance()
        addSubviews()
        configureLayout()
    }
    
    func updateData(saying: Saying) {
        self.sayingsImageView.image = UIImage(named: "Billy 11.png") // Temporary for test
        self.sayingsTextLabel.text = saying.text
        self.sayingsAuthorLabel.text = saying.author
    }
}

// MARK: - Appearance Methods

private extension SayingsCollectionViewCell {
    func setupAppearance() {
        sayingsLayerView.backgroundColor = .white

        sayingsLayerView.layer.cornerRadius = 15.0
        sayingsLayerView.layer.borderWidth = 0.0
        sayingsLayerView.layer.shadowColor = UIColor.lightGray.cgColor
        sayingsLayerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        sayingsLayerView.layer.shadowRadius = 3.0
        sayingsLayerView.layer.shadowOpacity = 1
        sayingsLayerView.layer.masksToBounds = false
        
        sayingsTextLabel.numberOfLines = 0
        sayingsTextLabel.minimumScaleFactor = 0.5
        sayingsTextLabel.adjustsFontSizeToFitWidth = true
        sayingsTextLabel.textAlignment = .left
        sayingsTextLabel.font = UIFont(name: "SFPro-Medium", size: CGFloat(16).adaptedFontSize)
        
        sayingsAuthorLabel.numberOfLines = 0
        sayingsTextLabel.minimumScaleFactor = 0.5
        sayingsAuthorLabel.adjustsFontSizeToFitWidth = true
        sayingsAuthorLabel.textAlignment = .right
        sayingsAuthorLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        sayingsAuthorLabel.font = UIFont(name: "SFPro-Regular", size: CGFloat(15).adaptedFontSize)
    }
    
    func addSubviews() {
        addSubview(sayingsLayerView)
        
        sayingsLayerView.addSubview(sayingsImageView)
        sayingsLayerView.addSubview(sayingsTextLabel)
        sayingsLayerView.addSubview(sayingsAuthorLabel)
    }
    
    func configureLayout() {
        sayingsLayerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-3.HAdapted)
        }
        
        sayingsImageView.snp.makeConstraints{ make in
            make.leading.top.equalTo(16.VAdapted)
            make.centerX.equalToSuperview()
            make.height.equalTo(sayingsImageView.snp.width)
        }
        
        sayingsTextLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(16.HAdapted)
            make.bottom.equalTo(-40.VAdapted)
            make.top.equalTo(sayingsImageView.snp.bottom).offset(10.VAdapted)
        }
        
        sayingsAuthorLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(16.HAdapted)
            make.height.equalTo(20.VAdapted)
            make.bottom.equalTo(-16.VAdapted)
        }
    }
}

