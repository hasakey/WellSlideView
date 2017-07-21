//
//  WellSlideView.h
//  NightConstruction
//
//  Created by 同筑科技 on 2017/7/21.
//  Copyright © 2017年 well. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WellSlideView;

@protocol WellSlideViewDelegate <NSObject>

- (void) headerView: (WellSlideView*)header selectedIndexChanged: (NSUInteger) index;

@end

@interface WellSlideView : UIScrollView

@property (nonatomic, weak) NSArray * sectionArray;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, weak) id<WellSlideViewDelegate> delegates;
@property (nonatomic,strong)NSArray * headerArray;
@property (nonatomic,assign)BOOL showSeparated;

+ (WellSlideView *)creatHeaderView;
- (void) setSelectedIndexAnimated:(NSUInteger)selectedIndex;
@end

