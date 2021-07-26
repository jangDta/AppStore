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
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    @IBOutlet weak var downloadButton: UIButton!
    
    let disposeBag = DisposeBag()
    let artworkImage = BehaviorRelay<UIImage>(value: UIImage())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        appImageView.image = nil
        thumbnailCollectionView.delegate = nil
        thumbnailCollectionView.dataSource = nil
    }
    
    private func configureUI() {
        appImageView.clipsToBounds = true
        appImageView.layer.cornerRadius = 10
        
        downloadButton.layer.cornerRadius = downloadButton.frame.height / 2
        
        thumbnailCollectionView.register(UINib(nibName: "ThumbnailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThumbnailCollectionViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 50) / 3
        let height = thumbnailCollectionView.frame.size.height
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumInteritemSpacing = 0.0
        thumbnailCollectionView.setCollectionViewLayout(flowLayout, animated: true)
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
        
        output.thumbnailImages
            .drive(thumbnailCollectionView.rx.items(cellIdentifier: "ThumbnailCollectionViewCell", cellType: ThumbnailCollectionViewCell.self)) { collectionView, image, cell in
                cell.thumbnailImage.accept(image)
            }
            .disposed(by: disposeBag)
    }

}
