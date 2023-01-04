//
//  UIImageView+Kingfisher.swift
//  TMDB-Movies-VIP
//
//  Created by Bradley Hoang on 01/01/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
    
    func cancelImageDownload() {
        kf.cancelDownloadTask()
    }
}
