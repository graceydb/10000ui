//
//  PullToFreshView.swift
//  10000ui-swift
//
//  Created by blurryssky on 2018/2/24.
//  Copyright © 2018年 blurryssky. All rights reserved.
//

import UIKit

class PullToFreshView: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
        }
    }
    
}

extension PullToFreshView: PullingRefreshing {
    
    func shouldRefresh(fraction: CGFloat) -> Bool {
        let shouldRefresh = fraction >= 1
        return shouldRefresh
    }
    
    func stateDidUpdate(_ state: PullingState) {
        switch state {
        case .pulling(let fraction):
            label.text = String(format: "pulling... %.2f", arguments: [fraction])
        case .willRefresh(let fraction):
            label.text = String(format: "relase to refresh... %.2f", arguments: [fraction])
        case .refreshing(let fraction):
            indicator.startAnimating()
            indicator.isHidden = false
            label.text = String(format: "refreshing... %.2f", arguments: [fraction])
        case .willTransition(let fraction):
            label.text = String(format: "relase to transition... %.2f", arguments: [fraction])
        case .transitioning(let fraction):
            label.text = String(format: "transitioning... %.2f", arguments: [fraction])
        case .resting(_):
            indicator.stopAnimating()
            indicator.isHidden = true
            label.text = "peace☺️"
        }
    }
}
