//
//  ThumbnailCollectionViewCell.swift
//  AppStore
//
//  Created by a60105114 on 2021/07/26.
//

import UIKit
import RxSwift
import RxCocoa

class ThumbnailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    let thumbnailImage = PublishRelay<UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        subscribe()
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
    }
    
    private func configureUI() {
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        thumbnailImageView.layer.borderWidth = 1
    }
    
    private func subscribe() {
        thumbnailImage.asDriverOnErrorJustComplete()
            .drive(thumbnailImageView.rx.image)
            .disposed(by: disposeBag)
    }

}

extension ThumbnailCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.size.width / 3
        let h = collectionView.frame.size.height
        print(w,h)
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
