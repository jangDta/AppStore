//
//  AppCollectionViewCell.swift
//  AppStore
//
//  Created by 장용범 on 2021/07/10.
//

import UIKit
import RxSwift
import RxCocoa

class AppCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var appSubtitleLabel: UILabel!
    
    let disposeBag = DisposeBag()
    let artworkImage = BehaviorRelay<UIImage>(value: UIImage())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        appImageView.image = nil
    }
    
    private func configureUI() {
        appImageView.clipsToBounds = true
        appImageView.layer.cornerRadius = 10
    }
    
    func bind(viewModel: AppViewModel) {
        let input = AppViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.title
            .drive(appTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.subtitle
            .drive(appSubtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.artworkImage
            .drive(appImageView.rx.image)
            .disposed(by: disposeBag)
    }

}
