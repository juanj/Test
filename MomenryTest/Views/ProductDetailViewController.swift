//
//  ProductDetailViewController.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!

    private let product: Product
    private let imageDownloader: ImageDownloader

    init(product: Product, imageDownloader: ImageDownloader) {
        self.product = product
        self.imageDownloader = imageDownloader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        nameContainerView.layer.cornerRadius = nameContainerView.frame.height / 2
        loadProduct()
    }

    private func loadProduct() {
        title = product.name
        nameLabel.text = product.name

        if let url = URL(string: product.url) {
            imageDownloader.downloadImageFromUrl(url) { image in
                self.productImageView.image = image
            }
        }
    }
}
