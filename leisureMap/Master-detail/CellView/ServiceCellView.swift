//
//  ServiceCellView.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit
import SDWebImage
class ServiceCellView: UICollectionViewCell {
    
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    func updateContent(service: ServiceCategory)->Void{
        lbName.text = service.Name
    
        bgImageView.sd_setImage(with: URL(string: service.ImagePath!), placeholderImage: UIImage(named: "placeholder"))
    
    }
}
