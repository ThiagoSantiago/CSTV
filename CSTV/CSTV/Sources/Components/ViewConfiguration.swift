//
//  ViewConfiguration.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

protocol ViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func buildLayout()
}

extension ViewConfiguration {
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() { }
}
