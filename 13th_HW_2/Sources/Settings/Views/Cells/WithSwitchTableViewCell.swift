//
//  WithSwitchTableViewCell.swift
//  13th-HW
//
//  Created by Максим Солобоев on 27.10.2022.
//

import UIKit
import SnapKit

class WithSwitchTableViewCell: UITableViewCell {
    
    static let indentifier = "withSwitchTableViewCell"
    
    // MARK: - Data
    
    private var cellData: CellData?
    
    // MARK: - Elements
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        return label
    }()
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var cellSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.addTarget(self, action: #selector(changeSwitch), for: .touchUpInside)
        return cellSwitch
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarcy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarcy() {
        contentView.addSubview(mainLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(cellSwitch)
        contentView.addSubview(iconView)
        iconView.addSubview(icon)
    }
    
    private func setupLayout() {
        iconView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(20)
            make.width.height.equalTo(30)
        }
        
        icon.snp.makeConstraints { make in
            make.center.equalTo(iconView)
            make.height.width.equalTo(23)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(iconView.snp.right).offset(20)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(15)
        }
        
        cellSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(20)
        }
    }
    
    // MARK: - Configuration
    
    func configuration(with instance: CellData) {
        self.cellData = instance
        icon.image = instance.icon
        mainLabel.text = instance.title
        detailLabel.text = instance.detailText
        iconView.backgroundColor = instance.imageBackgroundColor
        iconView.tintColor = instance.iconTintColor
    }
    
    // MARK: - Actions
    
    @objc func changeSwitch() {
        cellSwitch.isOn
        ? print("\(cellData?.title ?? "") is on")
        : print("\(cellData?.title ?? "") is off")
    }
}

