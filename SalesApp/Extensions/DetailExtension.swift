//
//  DetailExtension.swift
//  SalesApp
//
//  Created by Eyüphan Akkaya on 23.08.2023.
//

import Foundation
import UIKit

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}
