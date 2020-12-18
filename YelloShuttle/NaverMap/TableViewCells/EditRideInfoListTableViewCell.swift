//
//  EditRideInfoListTableViewCell.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/12.
//

import UIKit

class EditRideInfoListTableViewCell: UITableViewCell {

    // MARK:- Properties
    static let cellIdentifier = "EditRideInfoCell"
    
    var rideLabel: UILabel!
    var rideNick: UILabel!
    var VStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperties()
        contentView.addSubview(VStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupProperties()
        fatalError("init(coder:) has not been implemented")
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
    
    private func setupConstraints() {
        VStackView.translatesAutoresizingMaskIntoConstraints = false
        VStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        VStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        VStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        VStackView.addArrangedSubview(rideLabel)
        VStackView.addArrangedSubview(rideNick)
    }

}
