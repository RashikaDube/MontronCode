//
//  PetListViewController.swift
//  MontronCode
//
//  Created by Rashika Dube on 27/05/24.
//

import UIKit

class PetListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chattingButton: UIButton!
    @IBOutlet weak var callingButton: UIButton!
    
    // MARK: - Declarations
        
        private var viewModel: PetViewModel = PetViewModel()
        let afterHoursMessage =  "Work hours have ended. Please contact us again on the next work day"
        let officeHoursMessage = "Thank you for getting in touch with us. We'll get back to you as soon as possible."
        
        // MARK: - Methods
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            observeEvents()
            configureTableView()
            registerTableViewCells()
            initViewModel()
        }
        
        private func setupUI() {
            [chattingButton, callingButton].forEach { $0.layer.cornerRadius = 15 }
        }
        
        private func configureTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
        }
        
        private func registerTableViewCells() {
            tableView.register(UINib(nibName: Identifier.tableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.tableViewCell)
            tableView.register(UINib(nibName: Identifier.headerViewCell, bundle: nil), forCellReuseIdentifier: Identifier.headerViewCell)
        }
        
        private func initViewModel() {
            viewModel.fetchPetsData()
            viewModel.fetchConfigData()
        }
        
        private func observeEvents() {
            viewModel.eventHandler = { [weak self] event in
                guard let self = self else { return }
                
                switch event {
                case .loading, .stopLoading: break
                case .dataLoaded:
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .error(let error):
                    print(error)
                }
            }
        }
        
        private func showAlert(message: String) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        
        // MARK: - Button Actions
        
        @IBAction func callingButtonAction(_ sender: UIButton) {
            showAlert(message: isOfficeHours() ? officeHoursMessage : afterHoursMessage)
        }
        
        @IBAction func chattingButtonAction(_ sender: UIButton) {
            showAlert(message: isOfficeHours() ? officeHoursMessage : afterHoursMessage)
        }
    }

    // MARK: - UITableView Delegate & DataSource

    extension PetListViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.petsData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {            guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.tableViewCell, for: indexPath) as? TableViewCell else {
                return UITableViewCell()
        }
            
            let petData = viewModel.petsData[indexPath.row]
            cell.petNameLabel.text = petData.title ?? ""
            cell.configure(with: petData.imageUrl ?? "")
            cell.backgroundColor = .red
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            guard let header = tableView.dequeueReusableCell(withIdentifier: Identifier.headerViewCell) as? HeaderViewCell else {
                return UIView()
            }
            
            header.headerLabel.text = "Office Hours: \(viewModel.configData.settingsModel?.workHours ?? "M-F 9:00 - 18:00")"
            return header
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 75
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let webUrl = viewModel.petsData[indexPath.row].contentUrl else {
                print("Content URL is nil")
                return
            }
            
            guard let petInfoVC = storyboard?.instantiateViewController(withIdentifier: "PetInfoViewController") as? PetInfoViewController else {
                return
            }
            
            petInfoVC.targetURLString = webUrl
            navigationController?.pushViewController(petInfoVC, animated: true)
        }
    }
