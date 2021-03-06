//
//  LTViewPagerController.m
//  LTViewPager
//
//  Created by Alicia on 16/9/30.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import "LTViewPagerController.h"
#import "LTViewPagerHeader.h"
#import "UIView+JKFrame.h"

static NSString * const kViewPagerReuseId = @"ViewPagerCell";

static const CGFloat kTitleHeight = 40.0;
static const CGFloat kTitleInset = 10.0;
static const CGFloat kTitleFontSize = 15.0;
static const NSInteger kTagBase = 100;

@interface LTViewPagerController () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isInitial;
@property (nonatomic, assign) BOOL isEndDecelerating;
@property (nonatomic, assign) BOOL isDragging;
@property (nonatomic, assign) CGFloat lastOffsetX;
@property (nonatomic, strong) UICollectionView *contentView;

@end

@implementation LTViewPagerController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleHeight = kTitleHeight;
    self.titleTintColor = [UIColor blackColor];
    self.titleColor = [UIColor blackColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.isInitial) {
        self.isInitial = YES;
        [self p_setupTitles];
    }
}

#pragma mark - Public Method

- (void)selectedLabel:(UILabel *)label animated:(BOOL)animated {
    self.selectedLabel.textColor = self.titleColor;
    label.textColor = self.titleTintColor;
    _selectedLabel = label;
    
    [self p_setSeletedLabelTitleCenter];
}

- (void)didEndScrollingAnimation:(UIScrollView *)scrollView {
    // Impeletement in Child Controller
}

- (void)didEndDecelerating:(UIScrollView *)scrollView {
    // Impeletement in Child Controller
}
- (void)didScroll:(UIScrollView *)scrollView {
    // Impeletement in Child Controller
}

- (void)willBeginDragging:(UIScrollView *)scrollView {
    // Impeletement in Child Controller
}

#pragma mark - Gestures
- (void)tapTitle:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    [self selectedLabel:label animated:YES];
    
    NSInteger index = label.tag;
    index -= kTagBase;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.contentView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - Private Method
- (NSArray *)p_getTitlesWidth {
    NSMutableArray *titleWidthArray = [NSMutableArray arrayWithCapacity:self.controllerArray.count];
    for (int i = 0; i < self.controllerArray.count; i++) {
        UIViewController *controller = self.controllerArray[i];
        
        NSString *title = controller.title;
        
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
        
        CGFloat width = titleBounds.size.width;
        [titleWidthArray addObject:@(width)];
    }
    return titleWidthArray;
}

- (void)p_setupTitles {
    NSArray *titleWidthArray = [self p_getTitlesWidth];
    
    NSInteger count = self.controllerArray.count;
    CGFloat totalWidth = 0;
    for (int i = 0; i < count; i++) {
        UIViewController *controller = self.controllerArray[i];
        
        NSString *title = controller.title;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textColor = self.titleColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = self.titleFont;
        titleLabel.tag = kTagBase + i;
        
        CGFloat titleWidth;
        if (self.titleWidth == 0) {
            titleWidth = [titleWidthArray[i] floatValue];
            totalWidth += kTitleInset * 2 + titleWidth;
        } else {
            titleWidth = self.titleWidth;
            totalWidth += titleWidth;
        }
       
        titleLabel.frame = CGRectMake(totalWidth - titleWidth, 0, titleWidth, self.titleHeight);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitle:)];
        titleLabel.userInteractionEnabled = YES;
        [titleLabel addGestureRecognizer:tap];
        
        [self.titleScrollView addSubview:titleLabel];
        
        if (i == 0) {
            [self selectedLabel:titleLabel animated:NO];
        }
    }

    self.contentView.contentSize = CGSizeMake(count * self.view.jk_width, self.contentView.jk_height);
    self.titleScrollView.contentSize = CGSizeMake(totalWidth, self.titleScrollView.jk_height);
}

- (void)p_setSeletedLabelTitleCenter {
    CGFloat offsetX = self.selectedLabel.center.x - self.view.jk_width / 2;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - self.view.jk_width;
    if (maxOffsetX >= 0 && offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)p_selectLabelWithIndex:(NSUInteger)index {
    NSInteger selectedIndex = index + kTagBase;
    UILabel *label = [self.titleScrollView viewWithTag:selectedIndex];
    [self selectedLabel:label animated:NO];
    
    _isDragging = NO;
}

#pragma mark - ScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_isEndDecelerating) {
        _lastOffsetX = scrollView.contentOffset.x;
    }
    _isDragging = YES;
    _isEndDecelerating = NO;
    
    [self willBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self didScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isDragging = YES;
    _isEndDecelerating = YES;
    
    [self didEndDecelerating:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    [self p_selectLabelWithIndex:index];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self didEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    [self p_selectLabelWithIndex:index];
}

#pragma mark - Collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.controllerArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kViewPagerReuseId forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController *controller = self.controllerArray[indexPath.row];
    [self addChildViewController:controller];
    
    UIView *subView = (UIView *)controller.view;
    subView.frame = CGRectMake(0, 0, self.contentView.jk_width, self.contentView.jk_height);

    [cell.contentView addSubview:subView];
    return cell;
}

#pragma mark - Getters and Setters
- (UIScrollView *)titleScrollView {
    if (_titleScrollView) {
        return _titleScrollView;
    }
    
    _titleScrollView = [[UIScrollView alloc] init];
    _titleScrollView.scrollsToTop = NO;
    _titleScrollView.frame = CGRectMake(0, 0, self.view.jk_width, self.titleHeight);
    [self.view addSubview:_titleScrollView];
    return _titleScrollView;
}

- (UICollectionView *)contentView {
    if (_contentView) {
        return _contentView;
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _contentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _contentView.delegate = self;
    _contentView.dataSource = self;
    _contentView.pagingEnabled = YES;
    _contentView.showsHorizontalScrollIndicator = NO;
    CGFloat offsetY = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect frame = CGRectMake(0, offsetY, self.view.jk_width, self.view.jk_height - offsetY);
    _contentView.frame = frame;
    flowLayout.itemSize = frame.size;
    flowLayout.minimumLineSpacing = 0.1;
    _contentView.backgroundColor = self.view.backgroundColor;
    [_contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kViewPagerReuseId];
    [self.view addSubview:_contentView];
    return _contentView;
}

- (UIFont *)titleFont {
    if (_titleFont) {
        return _titleFont;
    }
    _titleFont = [UIFont systemFontOfSize:kTitleFontSize];
    return _titleFont;
}


@end
