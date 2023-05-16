//
//  DetaiView.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//

import UIKit

class FlightInfoView: UIView {
    
    let cityLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.toLayout()
        return view
    }()
    
    let timeLabel: UILabel = {
       let view = UILabel()
        view.toLayout()
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.toLayout()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        toLayout()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackViews() {
        
        [cityLabel, dateLabel, timeLabel].forEach(verticalStackView.addArrangedSubview(_:))
    }
    
    func setupViews() {
        setupStackViews()
        [verticalStackView].forEach(addSubview(_:))
        
        verticalStackView.anchor(top: topAnchor,
                                 leading: leadingAnchor,
                                 bottom: bottomAnchor,
                                 trailing: trailingAnchor)
    }
}
