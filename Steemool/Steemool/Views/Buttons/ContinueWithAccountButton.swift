//
//  ContinueWithAccountButton.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

class ContinueWithAccountButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupApearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupApearance() {
        self.backgroundColor = .white
        self.tintColor = .black
        
        self.frame = CGRect(x: 0, y: 0, width: 358, height: 52)
        self.clipsToBounds = true
        self.layer.cornerRadius = 13.HAdapted
        
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        
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
