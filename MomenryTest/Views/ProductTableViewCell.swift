//
//  ProductTableViewCell.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func prepareForReuse() {
        productImageView.image = nil
        nameLabel.text = ""
    }
}
