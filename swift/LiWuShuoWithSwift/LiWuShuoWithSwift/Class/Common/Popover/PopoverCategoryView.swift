//
//  PopoverCategoryView.swift
//  LiWuShuoWithSwift
//
//  Created by beyondSoft on 16/7/21.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

protocol PopoverCategoryViewDelegate: NSObjectProtocol {

    func selectedCategoryEndWithIndex(index: NSInteger)
}

class PopoverCategoryView: UIView {

    weak var delegate: PopoverCategoryViewDelegate?
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var switchBtn: UIButton!

    @IBOutlet weak var switchCover: UIView!

    //分类标题
    var categoryTitles: [NSString]? {

        didSet {
            //滚动的分类视图
             createScrollCategory(categoryTitles!)
            //弹出的分类视图
            popoverView = createPopoverView(categoryTitles!)
        }
    }

    //弹出分类视图的按钮列数
    let popverBtnColum = 4
    // 缓存滚动分类按钮
    var cacheScrollCategoryBtns = [UIButton]()
    // 缓存格子分类按钮
    var cacheSquareCategoryBtns = [UIButton]()
    // 当前所选的滚动分类按钮
    var selectedScrollCategoryBtn: UIButton?
    // 当前所选的格子分类按钮
    var selectedSquareCategoryBtn: UIButton?
    // 弹出的格子分类视图
    var popoverView: UIView?
    // 是否显示格子分类视图
    var showingPopoverView = false

    class func popoverCategoryView() -> PopoverCategoryView{

        let view = NSBundle.mainBundle().loadNibNamed("PopoverCategoryView", owner: nil, options: nil).last as! PopoverCategoryView
        return view
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {

        super.layoutSubviews()
        setupUIFrame()
    }

    //MARK:--视图
    private func setupUI(){

        backgroundColor = UIColor.whiteColor()
        //添加滚动红线
        scrollView.addSubview(scrollBottomLineView)
        //给
        let hideMaskCoverViewPan = UITapGestureRecognizer(target: self, action: #selector(PopoverCategoryView.hidePopoverView))
       maskCoverView.addGestureRecognizer(hideMaskCoverViewPan)
    }

    private func setupUIFrame(){

        if let lastCategoryBtn = cacheScrollCategoryBtns.last {

            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastCategoryBtn.frame), 0)
        }

        if let categoryBtn = selectedScrollCategoryBtn {

            scrollBottomLineView.center = CGPointMake(viewX(categoryBtn), bounds.height - 2.0)
            scrollBottomLineView.bounds = CGRect(origin: CGPointZero, size: CGSizeMake(viewWidth(categoryBtn) - 10.0, 2.0))
        }
    }

    private func showPopoverView(){

        backgroundColor = switchCover.backgroundColor
        switchBtn.selected = true
        switchCover.hidden = false
        //选择格子分类按钮
        squareCategoryBtnAction(cacheSquareCategoryBtns[selectedScrollCategoryBtn!.tag])
        //显示遮挡View
        showMaskCoverView()
        //显示筛选视图
        superview!.insertSubview(popoverView!, belowSubview: self)
        switchCover.alpha = 0
        showingPopoverView = true
        UIView.animateWithDuration(0.3) { 

            self.switchCover.alpha = 1.0
            self.popoverView?.frame.origin.y = self.bounds.height
        }
    }

    private func createPopoverView(titles: [NSString]) -> UIView{

        let btnWidth = screenWidth / CGFloat(popverBtnColum)
        let btnHeight: CGFloat = 50.0
        let popoverView = UIView()

        for i in 0..<titles.count {

            let colum = i % popverBtnColum
            let row = i / popverBtnColum
            let x = btnWidth * CGFloat(colum)
            let y = btnHeight * CGFloat(row)
            let btn = createBtn(titles[i])

            btn.tag = i
            btn.frame = CGRectMake(x, y, btnWidth, btnHeight)
            btn.addTarget(self, action: #selector(PopoverCategoryView.squareCategoryBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            popoverView.addSubview(btn)
            cacheSquareCategoryBtns.append(btn)
            //线条
            btn.addSubview(createVerticalLine(CGRectMake(viewWidth(btn) - 0.5, 0, 0.5, viewHeight(btn))))
               btn.addSubview(createHorizontalLine(CGRectMake(0, viewHeight(btn) - 0.5, viewWidth(btn), 0.5)))
            if i == 0 {
                squareCategoryBtnAction(btn)
            }
        }
        popoverView.addSubview(squareBottomLineView)
        popoverView.backgroundColor = UIColor.whiteColor()
        popoverView.frame = CGRectMake(0, -CGRectGetMaxY(cacheSquareCategoryBtns.last!.frame), screenWidth, -CGRectGetMaxY(cacheSquareCategoryBtns.last!.frame))

        return popoverView
    }

    private func createVerticalLine(frame: CGRect) ->UIView{

        let view = UIView(frame: frame)
        view.backgroundColor = Color_GlobalLine
        return view
    }

    private func createHorizontalLine(frame: CGRect) ->UIView{

        let view = UIView(frame: frame)
        view.backgroundColor = Color_GlobalLine
        return view
    }
    private func createScrollCategory(titles: [NSString]){

        for i in 0..<titles.count {

            let title = titles[i]
            let btn = createBtn(title)
            btn.tag = i


        }
    }

    private func createBtn(title: NSString) -> UIButton{

        let btn = UIButton()
        btn.setTitle(title as String, forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.setTitleColor(UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0), forState: UIControlState.Selected)
        return btn
    }

    @objc private func hidePopoverView(){

        guard let _ = popoverView else {
            return
        }
        backgroundColor = UIColor.whiteColor()

        switchBtn.selected = false
        switchCover.hidden = true
        //选择格子分类按钮
        scrollCategoryBtnAction(cacheScrollCategoryBtns[selectedSquareCategoryBtn!.tag])
    }

    //MARK:--事件

    @IBAction func switchBtnAction(sender: AnyObject) {

        if !sender.selected {
            showPopoverView()
        }else{
            hidePopoverView()
        }
    }
    
    @objc private func scrollCategoryBtnAction(sender: UIButton){

        if let btn = selectedScrollCategoryBtn { btn.selected = false}

        sender.selected = !sender.selected
        selectedScrollCategoryBtn = sender
        //重设分类标签状态
        if sender.center.x < bounds.width * 0.5 {

            scrollView.setContentOffset(CGPointZero, animated: true)
        }else if scrollView.contentSize.width > bounds.width && sender.center.x > bounds.width * 0.5 && sender.center.x < (scrollView.contentSize.width - bounds.width * 0.5) {

            scrollView.setContentOffset(CGPointMake(sender.frame.origin.x + sender.bounds.width * 0.5 - bounds.width * 0.5, 0), animated: true)
        }else{

            scrollView.setContentOffset(CGPointMake(max(scrollView.contentSize.width - scrollView.bounds.size.width, 0), 0), animated: true)
        }
        //需重新调用layoutSubviews
        setNeedsLayout()
        delegate?.selectedCategoryEndWithIndex(sender.tag)
    }

    @objc private func squareCategoryBtnAction(sender: UIButton){

        if let btn = selectedSquareCategoryBtn {
            btn.selected = false
        }

        sender.selected = !sender.selected
        selectedSquareCategoryBtn = sender
        squareBottomLineView.frame = CGRectMake(sender.frame.origin.x, CGRectGetMaxY(sender.frame), CGRectGetWidth(sender.frame), 2)

        if showingPopoverView {
            hidePopoverView()
        }
    }

     //显示遮挡View
    private func showMaskCoverView(){
        superview?.insertSubview(maskCoverView, belowSubview: self)
    }

    //隐藏遮挡View
    private func hideMaskCoverView(){
        maskCoverView.removeFromSuperview()
    }
    
    //MARK:--懒加载

    private var squareBottomLineView: UIView{

        let view = UIView()
        view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        return view
    }

    private var scrollBottomLineView:UIView = {

        let view = UIView()
        view.backgroundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        return view
    }()

    private lazy var maskCoverView: MaskCoverView = MaskCoverView()

}
