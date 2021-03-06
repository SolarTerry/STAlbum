//
//  ImagePreviewViewController.swift
//  Album
//
//  Created by solar on 17/4/17.
//  Copyright © 2017年 PigVillageStudio. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    // MARK: - 图片数组
    var images: [String]!
    // MARK: - 默认显示的图片索引
    var index: Int!
    // MARK: - 用来放置各个图片单元
    var collectionView: UICollectionView!
    // MARK: - 页控制器（小圆点）
    var pageControl: UIPageControl!
    
    // MARK: - 使用初始化
    init(images: [String], index: Int = 0) {
        self.images = images
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MAKR: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - 将背景色设为黑色
        self.view.backgroundColor = UIColor.black
        // collectionView尺寸样式
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.view.bounds.size
        // MARK: - 设置横向滚动
        layout.scrollDirection = .horizontal
        // MARK: - 不自动调整内边距，确保全屏
        self.automaticallyAdjustsScrollViewInsets = false
        // MARK: - collectionView初始化
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(ImagePreviewCollectionViewCell.self, forCellWithReuseIdentifier: "imagePreviewCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        self.view.addSubview(collectionView)
        
        // MARK: - 将视图滚动到默认图片上
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        // MARK: - 设置页控制器
        pageControl = UIPageControl()
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 20)
        pageControl.numberOfPages = images.count
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = index
        self.view.addSubview(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - ImagePreviewViewController的CollectionView相关协议方法实现
extension ImagePreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - 单元格数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    // MARK: - 单元格创建
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagePreviewCollectionViewCell", for: indexPath) as! ImagePreviewCollectionViewCell
        let image = UIImage(named: self.images[indexPath.row])
        cell.imageView.image = image
        return cell
    }
    // MARK: - collectionView将要显示
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ImagePreviewCollectionViewCell {
            // MARK: - 由于单元格是重用的，所以要重置内部元素尺寸
            cell.resetSize()
            // MARK: - 设置页控制器为当前页
            self.pageControl.currentPage = indexPath.item
        }
    }
}
