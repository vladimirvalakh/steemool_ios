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
        sayingsTextLabel.adjustsFontSizeToFitWidth = true
        sayingsTextLabel.textAlignment = .left
        sayingsTextLabel.font = UIFont(name: "SFPro-Regular", size: 15)
        sayingsTextLabel.frame = CGRect(x: 0, y: 0, width: 250, height: 363)
        
        sayingsAuthorLabel.numberOfLines = 0
        sayingsAuthorLabel.adjustsFontSizeToFitWidth = true
        sayingsAuthorLabel.textAlignment = .right
        sayingsAuthorLabel.font = UIFont.italicSystemFont(ofSize: 8)
        sayingsAuthorLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        sayingsAuthorLabel.font = UIFont(name: "SFProText-Medium", size: 10)
    }
    
    func addSubviews() {
        addSubview(sayingsLayerView)
        
        sayingsLayerView.addSubview(sayingsImageView)
        sayingsLayerView.addSubview(sayingsTextLabel)
        sayingsLayerView.addSubview(sayingsAuthorLabel)
    }
    
    func configureLayout() {
        sayingsLayerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(3.VAdapted)
            make.width.equalToSuperview()
        }
        
        sayingsImageView.snp.makeConstraints{ make in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(self.sayingsImageView.snp.height)
            make.height.equalTo(250.VAdapted) // image size
        }
        
        sayingsTextLabel.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-25.VAdapted)
            make.leading.equalTo(4.VAdapted)
            make.width.equalTo(246.HAdapted)
            make.height.equalTo(88.VAdapted)
        }
        
        sayingsAuthorLabel.snp.makeConstraints{ make in
            make.bottom.trailing.equalToSuperview().offset(-9.VAdapted)
            make.height.equalTo(12.VAdapted)
            make.centerX.equalToSuperview()
        }
    }
}

