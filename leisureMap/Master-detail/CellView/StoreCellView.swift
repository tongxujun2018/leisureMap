//
//  StoreCellView.swift
//  leisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 tripim. All rights reserved.
//

import UIKit

class StoreCellView: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
