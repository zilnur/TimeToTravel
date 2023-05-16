//
//  FlightTableViewCell.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    let departureСityView = CityAndTimeView()
    let cityOfArrivalView = CityAndTimeView()
    let priceLabel: UILabel = {
        let view = UILabel()
        view.toLayout()
        return view
    }()
    let likeImageView: UIImageView = {
        let view = UIImageView()
        view.toLayout()
        view.image = UIImage(systemName: "heart")
        view.tintColor = .purple
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [departureСityView, cityOfArrivalView, priceLabel, likeImageView].forEach(contentView.addSubview(_:))
        
        departureСityView.anchor(top: contentView.topAnchor,
                                 leading: contentView.leadingAnchor,
                                 padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        cityOfArrivalView.anchor(top: contentView.topAnchor,
                                 trailing: contentView.trailingAnchor,
                                 padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        priceLabel.anchor(top: departureСityView.bottomAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: contentView.bottomAnchor,
                          padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        likeImageView.anchor(top: cityOfArrivalView.bottomAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    func setValues(model: FlightModel) {
        departureСityView.dateLabel.text = model.startDate.convertToDate()
        departureСityView.timeLabel.text = model.startDate.convertToTime()
        departureСityView.cityLabel.text = model.startCity
        
        cityOfArrivalView.dateLabel.text = model.endDate.convertToDate()
        cityOfArrivalView.timeLabel.text = model.endDate.convertToTime()
        cityOfArrivalView.cityLabel.text = model.endCity
        
        priceLabel.text = "\(model.price.formatted()) р."
        
        likeImageView.image = UIImage(systemName: model.isLiked ? "heart.fill" : "heart")
    }

}
