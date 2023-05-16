//
//  CityAndTimeView.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//

import UIKit

class CityAndTimeView: UIView {

    let dateLabel: UILabel = {
        let view = UILabel()
        view.toLayout()
        view.textColor = .gray
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let timeLabel: UILabel = {
        let view = UILabel()
        view.toLayout()
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    let cityLabel: UILabel = {
        let view = UILabel()
        view.toLayout()
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toLayout()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [dateLabel, timeLabel, cityLabel].forEach {addSubview($0)}
        
        dateLabel.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         trailing: trailingAnchor)
        
        timeLabel.anchor(top: dateLabel.bottomAnchor,
                         leading: leadingAnchor,
                         trailing: trailingAnchor)
        
        cityLabel.anchor(top: timeLabel.bottomAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor)
    }
}
