//
//  SettingsViewController.swift
//  13th-HW
//
//  Created by Максим Солобоев on 27.10.2022.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private var cellInstances: [[CellData]] = CellData.getInstances()
    
    // MARK: - Elements
    
    private lazy var searcher: UISearchController = {
        let search = UISearchController()
        search.searchBar.placeholder = "Поиск"
        return search
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(StandartTableViewCell.self, forCellReuseIdentifier: StandartTableViewCell.indentifier)
        tableView.register(UserInfoViewCell.self, forCellReuseIdentifier: UserInfoViewCell.indentifier)
        tableView.register(WithSwitchTableViewCell.self, forCellReuseIdentifier: WithSwitchTableViewCell.indentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarcy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemGray6
    }
    
    private func setupHierarcy() {
        view.addSubview(tableView)
        navigationItem.searchController = searcher
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(view)
        }
    }
}

// MARK: - DataSource extension

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        cellInstances.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellInstances[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellInstances[indexPath.section][indexPath.row]
        switch cellModel.type {
        case .userInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoViewCell.indentifier)
                    as? UserInfoViewCell else {
                return UITableViewCell()
            }
            cell.configuration(with: cellModel)
            cell.accessoryType = .disclosureIndicator
            return cell
        case .standart:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StandartTableViewCell.indentifier)
                    as? StandartTableViewCell else {
                return UITableViewCell()
            }
            cell.configuration(with: cellModel)
            cell.accessoryType = .disclosureIndicator
            return cell
        case .withSwitch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WithSwitchTableViewCell.indentifier)
                    as? WithSwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configuration(with: cellModel)
            cell.selectionStyle = .none
            cell.accessoryType = .none
            return cell
        }
    }
}

// MARK: - Delegate extension

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = cellInstances[indexPath.section][indexPath.row].type
        return type == .userInfo ? 90 : 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = cellInstances[indexPath.section][indexPath.row]
        if model.type != .withSwitch {
            let viewController = DetailViewController(model: model)
            print("Выбран пункт: \(model.title)")
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("Пункт \(model.title) не имеет DetailView")
        }
    }
}
