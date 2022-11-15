//
//  DetailViewController.swift
//  13th-HW
//
//  Created by Максим Солобоев on 27.10.2022.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    // MARK: - Data
    
    private let model: CellData
    
    // MARK: - Outlets
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.tintColor = .white
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var detailTitleText: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return lable
    }()
    
    // MARK: - Lifecycle
    
    init(model: CellData) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .white
        icon.image = model.icon
        detailTitleText.text = model.title
        iconView.backgroundColor = model.imageBackgroundColor
        icon.tintColor = model.iconTintColor
    }
    
    private func setupHierarchy() {
        view.addSubview(iconView)
        view.addSubview(detailTitleText)
        iconView.addSubview(icon)
    }
    
    private func setupLayout() {
        iconView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.width.equalTo(80)
        }
        
        icon.snp.makeConstraints { make in
            make.center.equalTo(iconView)
            make.height.width.equalTo(60)
        }
        
        detailTitleText.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(90)
        }
    }
}
