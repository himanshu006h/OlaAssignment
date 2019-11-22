//
//  cabInfoCollectionViewCell.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class cabInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cabImage: AsyncImageView!
    @IBOutlet weak var lblCabInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpUI()
    }
    
    func setUpUI() {
        self.cabImage.layer.borderColor = UIColor.white.cgColor
    }
    
    func configureCell(details: MapDetailsModel) {
        self.lblCabInfo.text = details.modelName
        guard let imageLink = details.carImageUrl else { return }
        self.cabImage.loadImage(urlString: imageLink, completion: { _ in })
    }

}

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
