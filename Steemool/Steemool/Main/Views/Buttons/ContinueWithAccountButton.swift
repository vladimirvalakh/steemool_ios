//
//  ContinueWithAccountButton.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

class ContinueWithAccountButton: UIButton {
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupApearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupApearance() {
        self.backgroundColor = .white
        self.tintColor = .black
        
        self.frame = CGRect(x: 0, y: 0, width: 358.HAdapted, height: 52.VAdapted)
        self.clipsToBounds = true
        self.layer.cornerRadius = 13.HAdapted
        
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "SFProText-Regular", size: CGFloat(17).adaptedFontSize)
        
        self.imageEdgeInsets.left = -6.HAdapted
    }
}

extension UIImage {
    func resizedImage(Size sizeImage: CGSize) -> UIImage? {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: sizeImage.width, height: sizeImage.height))
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        self.draw(in: frame)
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.withRenderingMode(.alwaysOriginal)
        return resizedImage
    }
}
