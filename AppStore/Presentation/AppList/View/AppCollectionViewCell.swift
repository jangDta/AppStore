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
    var viewModel = PublishSubject<AppViewModel>()
    let artworkImage = BehaviorRelay<UIImage>(value: UIImage())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        subscribe()
    }
    
    override func prepareForReuse() {
        appImageView.image = nil
    }
    
    private func configureUI() {
        appImageView.clipsToBounds = true
        appImageView.layer.cornerRadius = 10
    }
    
    func subscribe() {
        // ViewModel
        viewModel.subscribe(onNext: { appViewModel in
            self.appTitleLabel.text = appViewModel.appModel.trackName
            self.appSubtitleLabel.text = appViewModel.appModel.artistName
            
            guard let artworkUrlString = appViewModel.appModel.artwork else { return }
            
            if let cachedImage = ImageCache.shared.object(forKey: NSString(string: artworkUrlString)) {
                self.artworkImage.accept(cachedImage)
            } else {
                appViewModel.fetchArtworkImage(artworkUrlString).subscribe(onNext: { image in
                    ImageCache.shared.setObject(image, forKey: NSString(string: artworkUrlString))
                    self.artworkImage.accept(image)
                })
                .disposed(by: self.disposeBag)
            }
        })
        .disposed(by: disposeBag)
        
        // AppImage
        artworkImage.asDriver()
            .drive(appImageView.rx.image)
            .disposed(by: disposeBag)
    }

}
