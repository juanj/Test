//
//  ImageDownloader.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import UIKit

protocol ImageDownloader {
    func downloadImageFromUrl(_ url: URL, completion: @escaping (UIImage?) -> Void)
}
