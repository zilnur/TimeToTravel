//
//  ViewController.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 12.05.2023.
//

import UIKit
import Combine

class FlightsViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: FlightsPresenterProtocol!
    
    private lazy var ticketsTableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(FlightTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.toLayout()
        return view
    }()
    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateFlights()
        ticketsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        indicatorActivate()
        presenter?.setModel {  [weak self] error in
            guard let self else { return }
            if let error {
                DispatchQueue.main.async {
                    self.showAlert(error: error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    self.indicatorDeactivate()
                    self.ticketsTableView.reloadData()
                }
            }
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [ticketsTableView, activityIndicator].forEach(view.addSubview(_:))
        ticketsTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.safeAreaLayoutGuide.leadingAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                trailing: view.safeAreaLayoutGuide.trailingAnchor)
        [
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ].forEach {$0.isActive = true}
    }
    
    func indicatorActivate() {
        activityIndicator.startAnimating()
    }
    
    func indicatorDeactivate() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func showAlert(error: String) {
        let alertController = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertOk)
        present(alertController, animated: true)
    }

}

//MARK: - UITableViewDelegate & UITableViewDataSourse
extension FlightsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getModel().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FlightTableViewCell else {
            return UITableViewCell()
        }
        cell.setValues(model: presenter!.getModel()[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToNextView(index: indexPath)
    }
}
