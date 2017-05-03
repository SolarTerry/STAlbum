//
//  InfoTableViewCell.swift
//  Album
//
//  Created by solar on 17/4/7.
//  Copyright © 2017年 PigVillageStudio. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    // MARK: - 用户头像
    @IBOutlet weak var userLogoImageView: UIImageView!
    // MARK: - 用户名
    @IBOutlet weak var usernameLabel: UILabel!
    // MARK: - 发布时间
    @IBOutlet weak var timeLabel: UILabel!
    // MARK: - 内容
    @IBOutlet weak var contentLabel: UILabel!
    // MARK: - 配图
    @IBOutlet weak var picturesCollectionView: UICollectionView!
    // MARK: - 图片名称数组
    var pictures:[String] = []
    // MARK: - 图片collection的高度
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    // MARK: - 内容label的高度
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // MARK: - 继承collection的delegate和datasource
        self.picturesCollectionView.delegate = self
        self.picturesCollectionView.dataSource = self
        // MARK: - 注册ImageCollectionViewCell
        self.picturesCollectionView.register(UINib(nibName:"ImageCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "imageCell")
    }
    
    func reloadData(userLogoImage: UIImage, username: String, time: String, content: String, pictures: [String]) {
        self.userLogoImageView.image = userLogoImage
        self.usernameLabel.text = username
        self.timeLabel.text = time
        // MARK: - 使UILabel里的文字换行
        self.contentLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        self.contentLabel.numberOfLines = 0
        self.contentLabel.text = content
        // MARK: - 使UILabel根据文字内容自适应高度
        let contentLabelText: NSString = self.contentLabel.text! as NSString
        let attributes = [NSFontAttributeName: self.contentLabel.font!]
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let contentLabelSize = contentLabelText.boundingRect(with: CGSize(width: UIScreen.main.bounds.width, height: 0), options: options, attributes: attributes, context: nil)
        self.labelHeight.constant = contentLabelSize.height
    
        self.pictures = pictures
        // MARK: - 刷新collection获取最新高度
        self.picturesCollectionView.reloadData()
        let contentSize = self.picturesCollectionView.collectionViewLayout.collectionViewContentSize
        collectionViewHeight.constant = contentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = picturesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        cell.pictureImageView.image = UIImage(named: pictures[indexPath.item])
        cell.pictureImageView.tag = indexPath.item
        cell.pictureImageView.contentMode = .scaleAspectFit
        cell.pictureImageView.clipsToBounds = true
        // MARK: - 设置允许交互
        cell.pictureImageView.isUserInteractionEnabled = true
        // MARK: - 1.添加单击监听
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(imageViewTap(_:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        cell.pictureImageView.addGestureRecognizer(tapSingle)
        return cell
    }
    
    // MARK: - 缩略图点击处理方法
    func imageViewTap(_ recognizer:UITapGestureRecognizer) {
        // MARK: - 图片索引
        let index = recognizer.view!.tag
        // MARK: - 进入图片全屏展示
        let previewVC = ImagePreviewViewController(images: pictures, index: index)
        let vc = self.responderViewController()
        vc?.present(previewVC, animated: true, completion: nil)
    }
    
    // MARK: - 查找所在的ViewController
    func responderViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
