//
//  CabInfoCell.swift
//  OlaAssignment
//
//  Created by Himanshu Saraswat on 21/11/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class CabInfoCell: UITableViewCell {

    @IBOutlet weak var cabImage: AsyncImageView!
    @IBOutlet weak var lblCabInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(details: MapDetailsModel) {
        self.lblCabInfo.text = details.modelName
        guard let imageLink = details.carImageUrl else { return }
        self.cabImage.loadImage(urlString: imageLink, completion: { _ in })
    }
    
}
