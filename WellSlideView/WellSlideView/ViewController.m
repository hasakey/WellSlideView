//
//  ViewController.m
//  WellSlideView
//
//  Created by 同筑科技 on 2017/7/21.
//  Copyright © 2017年 well. All rights reserved.
//

#define collectionViewCellHeight 240
#define lineHeight 10

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "WellSlideView.h"
#import "TrendDetailSecondCellCollectionViewFirstCell.h"
#import "TrendDetailSecondCellCollectionViewSecondCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WellSlideViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)WellSlideView *switchView;


@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpSubViews];
}

-(void)setUpSubViews
{
    [self.view addSubview:self.switchView];
    [self.view addSubview:self.collectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TrendDetailSecondCellCollectionViewFirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"trendDetailSecondCellCollectionViewFirstCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }
    else
    {
        TrendDetailSecondCellCollectionViewSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"trendDetailSecondCellCollectionViewSecondCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor blueColor];
        return cell;
    }
    
}

/**
 *  滑动结束后执行的方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self.switchView setSelectedIndexAnimated:page];
    
}

/**
 *  scrollView代理   必须要用
 */

-(void)headerView:(WellSlideView *)header selectedIndexChanged:(NSUInteger)index
{
    [self.collectionView scrollRectToVisible:CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, collectionViewCellHeight) animated:YES];
}


-(WellSlideView *)switchView
{
    if (!_switchView) {
        _switchView = [[WellSlideView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
        _switchView.headerArray = @[@"分时价格",@"数据统计"];
        _switchView.delegates = self;
    }
    return _switchView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        //item行间距
        flowLayout.minimumLineSpacing = 0;//默认10
        flowLayout.minimumInteritemSpacing = 0;//默认10
        //设置统一大小的item
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH,collectionViewCellHeight);//默认50
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//默认竖直滚动
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//边距屏幕宽
        
        _collectionView =  [[UICollectionView alloc]initWithFrame:CGRectMake(0, lineHeight + 50, SCREEN_WIDTH, collectionViewCellHeight) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        
        
        //注册
        [_collectionView registerClass:[TrendDetailSecondCellCollectionViewFirstCell class] forCellWithReuseIdentifier:@"trendDetailSecondCellCollectionViewFirstCell"];
        
        [_collectionView registerClass:[TrendDetailSecondCellCollectionViewSecondCell class] forCellWithReuseIdentifier:@"trendDetailSecondCellCollectionViewSecondCell"];
    }
    return _collectionView;
}




@end
