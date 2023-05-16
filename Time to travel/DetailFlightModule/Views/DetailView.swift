//
//  DetailView.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//

import UIKit

class DetailView: UIView {

    let departureView = FlightInfoView()
    let arrivalView = FlightInfoView()
    let pathView = PathView()
    
    let priceLabel: UILabel = {
        let view = UILabel()
        view.toLayout()
        return view
    }()
    
    lazy var likeButton: UIButton = {
        let view = UIButton()
        view.toLayout()
        view.tintColor = .purple
        view.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return view
    }()
    
    var buttonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        toLayout()
        layerConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func layerConfig() {
        backgroundColor = .white
        layer.cornerRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }

    private func setupViews() {
        [departureView, arrivalView, pathView, priceLabel, likeButton].forEach(addSubview(_:))
        departureView.anchor(top: topAnchor,
                             leading: pathView.trailingAnchor,
                             trailing: trailingAnchor,
                             padding: .init(top: 30, left: 10, bottom: 0, right: 30))
        arrivalView.anchor(top: departureView.bottomAnchor,
                           leading: pathView.trailingAnchor,
                           trailing: trailingAnchor,
                           padding: .init(top: 30, left: 10, bottom: 0, right: 30))
        pathView.anchor(top: departureView.centerYAnchor,
                        leading: leadingAnchor,
                        bottom: arrivalView.centerYAnchor,
                        padding: .init(top: 0, left: 30, bottom: -20, right: 0))
        priceLabel.anchor(top: arrivalView.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          padding: .init(top: 20, left: 30, bottom: 30, right: 0))
        likeButton.anchor(bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          padding: .init(top: 20, left: 0, bottom: 30, right: 30))
    }
    
    func setValues(model: FlightModel) {
        departureView.cityLabel.text = model.startCity
        departureView.dateLabel.text = model.startDate.convertToDate()
        departureView.timeLabel.text = model.startDate.convertToTime()
        arrivalView.cityLabel.text = model.endCity
        arrivalView.dateLabel.text = model.endDate.convertToDate()
        arrivalView.timeLabel.text = model.endDate.convertToTime()
        priceLabel.text = "Цена: " + model.price.formatted() + "р."
        buttonImageConfig(isLiked: model.isLiked)
    }
    
    func buttonImageConfig(isLiked: Bool) {
        likeButton.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
    }
    
    @objc private func likeTapped() {
        guard let buttonTapped else { return }
        buttonTapped()
    }
}

