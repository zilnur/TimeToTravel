//
//  DetailViewController.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//
//departure city
//city of arrival
import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol!
    
    private let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [detailView].forEach(view.addSubview(_:))
        
        [detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ].forEach {$0.isActive = true}
    }
    
    //Устанавливает значения в UI элементах
    func configViews() {
        detailView.setValues(model: presenter.getModel())
        detailView.buttonTapped = { [weak self] in
            guard let self,
                  let presenter else { return }
            if presenter.getModel().isLiked {
                presenter.deleteFlight()
                self.detailView.buttonImageConfig(isLiked: presenter.getModel().isLiked)
            } else {
                presenter.saveFlight()
                self.detailView.buttonImageConfig(isLiked: presenter.getModel().isLiked)
            }
        }
    }

}
