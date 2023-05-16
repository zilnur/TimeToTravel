//
//  PathView.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//

import UIKit

class PathView: UIView {

    private lazy var departurePlaneImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "airplane.departure")
        view.tintColor = .purple
        view.toLayout()
        return view
    }()
    
    private lazy var arrivalPlaneImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "airplane.arrival")
        view.tintColor = .purple
        view.toLayout()
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLine()
    }
    
    func setupViews() {
        [departurePlaneImageView, arrivalPlaneImageView].forEach(addSubview(_:))
        backgroundColor = .white
        departurePlaneImageView.anchor(top: topAnchor,
                                       leading: leadingAnchor,
                                       trailing: trailingAnchor,
                                       padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        arrivalPlaneImageView.anchor(leading: leadingAnchor,
                                     bottom: bottomAnchor,
                                     trailing: trailingAnchor,
                                     padding: .init(top: 0, left: 20, bottom: 0, right: 0))
    }
    
    func drawLine() {
        let path = UIBezierPath()
        let startPoint = CGPoint(x: departurePlaneImageView.frame.minX - 10,
                                 y: departurePlaneImageView.frame.midY)
        let endPoint = CGPoint(x: arrivalPlaneImageView.frame.minX - 10,
                               y: arrivalPlaneImageView.frame.midY)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        let color = UIColor.purple
        color.setStroke()
        path.lineWidth = 2
        path.stroke()
    }
    
    func drawCircle() {
        let path = UIBezierPath()
        path.addClip()
    }
}


