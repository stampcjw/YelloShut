//
//  DriverInfoTableViewCell.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/05.
//

import UIKit

class DriverInfoTableViewCell: UITableViewCell {

    // MARK:- Properties    
    static let cellIdentifier = "defaultCell"
    
    var HStackView: UIStackView!
    var VStackView: UIStackView!
    var driverView: UIView!
    var driverImage: UIImageView!
    var driverName: UILabel!
    var driverNumber: UILabel!
    var driverCarNumber: UILabel!
    var academy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupProperties()
        
        contentView.addSubview(driverView)
        contentView.addSubview(VStackView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupProperties()
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProperties() {
        VStackView = UIStackView()
        VStackView.axis = .vertical
        VStackView.distribution = .fillEqually
        VStackView.alignment = .fill
        
        driverView = UIView(frame: CGRect(x: 0, y: 0, width: 130, height: 130))
                
        driverImage = UIImageView(image: UIImage(named: "driver"))
        driverImage.contentMode = .scaleAspectFit
        driverImage.clipsToBounds = true
        
        driverName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
//        driverName = UILabel()
        driverName.textColor = .black
        driverName.font = UIFont.systemFont(ofSize: 15)
        driverName.textAlignment = .left
        driverName.numberOfLines = 0

        driverNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
//        driverNumber = UILabel()
        driverNumber.textColor = .black
        driverNumber.font = UIFont.systemFont(ofSize: 15)
        driverNumber.textAlignment = .left
        driverNumber.numberOfLines = 0
        
        driverCarNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
//        driverCarNumber = UILabel()
        driverCarNumber.textColor = .black
        driverCarNumber.font = UIFont.systemFont(ofSize: 15)
        driverCarNumber.textAlignment = .left
        driverCarNumber.numberOfLines = 0
        
        academy = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
//        academy = UILabel()
        academy.textColor = .black
        academy.font = UIFont.systemFont(ofSize: 15)
        academy.textAlignment = .left
        academy.numberOfLines = 0
    }
    
    private func makeConstraints() {

        driverView.translatesAutoresizingMaskIntoConstraints = false
        driverView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        driverView.heightAnchor.constraint(equalToConstant: 130
        ).isActive = true
        driverView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        driverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        driverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        driverView.addSubview(driverImage)

        driverImage.translatesAutoresizingMaskIntoConstraints = false
        driverImage.topAnchor.constraint(equalTo: driverView.topAnchor).isActive = true
        driverImage.leadingAnchor.constraint(equalTo: driverView.leadingAnchor).isActive = true
        driverImage.trailingAnchor.constraint(equalTo: driverView.trailingAnchor).isActive = true
        driverImage.bottomAnchor.constraint(equalTo: driverView.bottomAnchor).isActive = true
        
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        VStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        VStackView.leadingAnchor.constraint(equalTo: driverView.trailingAnchor, constant: 10).isActive = true
//        VStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        VStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        VStackView.addArrangedSubview(driverName)
        VStackView.addArrangedSubview(driverNumber)
        VStackView.addArrangedSubview(driverCarNumber)
        VStackView.addArrangedSubview(academy)
        
//        driverName.translatesAutoresizingMaskIntoConstraints = false
//        driverName.widthAnchor.constraint(equalToConstant: 130).isActive = true
//        driverName.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        driverName.topAnchor.constraint(equalTo: VStackView.topAnchor).isActive = true
//        driverName.leadingAnchor.constraint(equalTo: VStackView.leadingAnchor).isActive = true
//
//        driverNumber.translatesAutoresizingMaskIntoConstraints = false
//        driverNumber.widthAnchor.constraint(equalTo: driverName.widthAnchor).isActive = true
//        driverNumber.heightAnchor.constraint(equalTo: driverName.heightAnchor).isActive = true
//        driverNumber.topAnchor.constraint(equalTo: driverName.bottomAnchor).isActive = true
//        driverNumber.leadingAnchor.constraint(equalTo: driverName.leadingAnchor).isActive = true
//
//        driverCarNumber.translatesAutoresizingMaskIntoConstraints = false
//        driverCarNumber.widthAnchor.constraint(equalTo: driverName.widthAnchor).isActive = true
//        driverCarNumber.heightAnchor.constraint(equalTo: driverName.heightAnchor).isActive = true
//        driverCarNumber.topAnchor.constraint(equalTo: driverNumber.bottomAnchor).isActive = true
//        driverCarNumber.leadingAnchor.constraint(equalTo: driverName.leadingAnchor).isActive = true
//
//        academy.translatesAutoresizingMaskIntoConstraints = false
//        academy.widthAnchor.constraint(equalTo: driverName.widthAnchor).isActive = true
//        academy.heightAnchor.constraint(equalTo: driverName.heightAnchor).isActive = true
//        academy.topAnchor.constraint(equalTo: driverCarNumber.bottomAnchor).isActive = true
//        academy.leadingAnchor.constraint(equalTo: driverName.leadingAnchor).isActive = true
    }
}
