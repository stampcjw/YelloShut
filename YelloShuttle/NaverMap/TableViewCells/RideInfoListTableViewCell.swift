//
//  RideListTableViewCell.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/06.
//

import UIKit

class RideInfoListTableViewCell: UITableViewCell {

    // MARK:- Properties
    static let cellIdentifier = "rideListCell"
    
    var rideLabel: UILabel!
    var rideNick: UILabel!
    var VStackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupProperties()
        
        contentView.addSubview(VStackView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupProperties()
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupProperties() {
        rideLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        rideLabel.font = UIFont.systemFont(ofSize: 15)
        rideLabel.textColor = .black
        
        rideNick = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        rideNick.font = UIFont.systemFont(ofSize: 12)
        rideNick.textColor = .systemPink
        
        VStackView = UIStackView()
        VStackView.axis = .vertical
        VStackView.distribution = .fillEqually
        VStackView.alignment = .fill
        VStackView.spacing = 2
    }
    
    private func makeConstraints() {
    
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        VStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        VStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        VStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        VStackView.addArrangedSubview(rideLabel)
        VStackView.addArrangedSubview(rideNick)
        
        
//        rideLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        rideNick.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            rideLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            rideLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
//
//            rideNick.topAnchor.constraint(equalTo: rideLabel.bottomAnchor, constant: 3),
//            rideNick.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
//        ])
    }
}
