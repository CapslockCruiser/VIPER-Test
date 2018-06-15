//
//  AchievementsView.swift
//  VIPER Test
//
//  Created by William Choi on 6/10/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

final class AchievementsViewController: UIViewController {
    
    // MARK: UI elements
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Custom properties
    
    var presenter: AchievementsViewToPresenterProtocol?
    private let cvCellReuseID = "AchievementCVCellReuseID"
    private var achievementsViewModels: [AchievementViewModel] = []
    private let horizontalPadding: CGFloat = 48
    private let verticalPadding: CGFloat = 24
    private let cellCornerRadius: CGFloat = 8
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        presenter?.setupView()
        presenter?.requestUpdate()
    }
}

extension AchievementsViewController: AchievementsPresenterToViewProtocol {
    func setupView(navTitle: String) {
        self.title = navTitle
    }
    
    func showAchievements(_ achievementsViewModels: [AchievementViewModel]) {
        self.achievementsViewModels = achievementsViewModels
        
        DispatchQueue.main.async { [weak self] in
            if let strongSelf = self {
                strongSelf.collectionView.reloadData()
            }
        }
    }
}

extension AchievementsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievementsViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cvCellReuseID, for: indexPath) as? AchievementsCell else { return UICollectionViewCell() }
        cell.layer.cornerRadius = cellCornerRadius
        cell.clipsToBounds = true
        cell.configure(viewModel: achievementsViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height / 3) - verticalPadding
        let width = (collectionView.bounds.width) - horizontalPadding
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}

// MARK: CollectionView cell

final class AchievementsCell: UICollectionViewCell {
    
    @IBOutlet weak var levelBackgroundView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var bgImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        levelBackgroundView.layer.cornerRadius = levelBackgroundView.bounds.width / 2
        levelBackgroundView.clipsToBounds = true
        progressView.layer.cornerRadius = progressView.bounds.height / 2
        progressView.clipsToBounds = true
        progressView.progressTintColor = UIColor.green
        if let sublayer = progressView.layer.sublayers?[1] {
            sublayer.cornerRadius = progressView.bounds.height / 2
            progressView.subviews[1].clipsToBounds = true
        }
    }
    
    fileprivate func configure(viewModel: AchievementViewModel) {
        levelLabel.text = viewModel.level
        progressView.progress = Float(viewModel.progress) / Float(viewModel.total)
        progressLabel.text = String(viewModel.progress) + "pts"
        maxLabel.text = String(viewModel.total) + "pts"
        if viewModel.accessible == true {
            blurView.alpha = 0
        } else {
            blurView.alpha = 0.5
        }
        bgImageView.image = viewModel.image
    }
}
