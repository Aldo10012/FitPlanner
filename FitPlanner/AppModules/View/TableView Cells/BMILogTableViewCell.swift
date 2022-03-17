//
//  BMILogTableViewCell.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 3/17/22.
//

import UIKit

class BMILogTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var card = FPBackground(radius: 8)
    
    var dateLabel = FPLabel(title: "Date", color: .primary, size: 16, weight: .medium)
    var bmiLabel = FPLabel(title: "BMI", color: .primary, size: 16, weight: .medium)
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        let attributedTitle = self.setAttributedText("0.0")
        label.attributedText = attributedTitle
        return label
    }()
    
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    // MARK: UI
    func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        selectionStyle = .none
        
        contentView.addSubviews(card)
        
        card.backgroundColor = .white
        card.addSubviews(dateLabel, bmiLabel, weightLabel)
        card.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor, paddingLeft: 10, paddingRight: 10)
        card.centerY(inView: contentView)
        card.setConstantHeight(height: 80)
        card.addStandardShadow()
        
        dateLabel.anchor(left: card.leftAnchor, bottom: card.centerYAnchor, paddingLeft: 15, paddingBottom: 5)
        bmiLabel.anchor(top: card.centerYAnchor, left: card.leftAnchor, paddingTop: 5, paddingLeft: 15)
        weightLabel.anchor(right: card.rightAnchor, paddingRight: 15)
        weightLabel.centerY(inView: card)
    }
    
    
    // MARK: Helpers
    func setAttributedText(_ text: String) ->  NSAttributedString? {
        let attributedTitle = NSMutableAttributedString(
            string: "\(text)  ",
            attributes: [
                .font: UIFont.systemFont(ofSize: 30, weight: .medium),
                .foregroundColor: UIColor.FPLabelPrimary
            ])
        attributedTitle.append(NSAttributedString(
            string: "lbs",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                .foregroundColor: UIColor.FPLabelPrimary
            ])
        )
        
        return attributedTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
