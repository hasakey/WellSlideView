//
//  WellSlideView.m
//  NightConstruction
//
//  Created by 同筑科技 on 2017/7/21.
//  Copyright © 2017年 well. All rights reserved.
//

#import "WellSlideView.h"
#import "UIView+Frame.h"
@interface WellSlideView()


@property (nonatomic, strong) UIView * indicatorView;

@property (nonatomic) NSArray * buttonArray;

@property (nonatomic, weak) UIButton * selectedButton;
@property (nonatomic) BOOL modify;


@end
@implementation WellSlideView
+ (id)creatHeaderView{
    
    return [[self alloc]init];
    
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self  =   [super initWithFrame:frame]) {
        
        
    }
    return  self;
}


- (void)setUpBottomLine
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
    //    line.backgroundColor = LineColor;
    line.backgroundColor = [UIColor redColor];
    
    [self addSubview:line];
}

- (UIButton *)selectedButton
{
    return self.buttonArray[self.selectedIndex];
}

- (void)setHeaderArray:(NSArray *)headerArray{
    
    NSMutableArray *buttonArray = [NSMutableArray arrayWithCapacity:headerArray.count];
    
    _headerArray = headerArray;
    float x = 0;
    for (NSString * title in headerArray) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = [UIColor clearColor];
        button.frame= CGRectMake(x, 0, self.width / headerArray.count, self.height);
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        button.layer.cornerRadius = 4;
        button.clipsToBounds = YES;
        [self addSubview:button];
        [buttonArray addObject:button];
        
        if (!_showSeparated) {
        }
        if (x == 0) {
            button.selected = YES;
            
        }
        [button addTarget:self action:@selector(sectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        x += self.width / headerArray.count;
    }
    [self creatUI];
    self.buttonArray = buttonArray;
    self.contentSize = CGSizeMake(x, 1);
    
}
- (void)sectionButtonClicked:(UIButton *)button{
    
    NSUInteger newIndex = [self.buttonArray indexOfObject:button];
    if (newIndex==self.selectedIndex) {
        return;
    }
    self.selectedIndex = newIndex;
    [self setSelectedIndexAnimated:newIndex];
    
}

#pragma mark 按钮外面红色的框
- (void)creatUI{
    
    NSString *str =  self.headerArray[0];
    CGSize textSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.f]}];
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(self.selectedButton.x + 10, self.height - 2, textSize.width , 2) ];
    //    NSLog(@"%f",self.selectedButton.middleX);
    CGPoint point = CGPointMake(self.width / self.headerArray.count / 2, self.height - 2 + 1);
    self.indicatorView.center = point;
    
    self.indicatorView.backgroundColor = [UIColor orangeColor];
    self.indicatorView.layer.cornerRadius = 4;
    self.indicatorView.clipsToBounds = YES;
    [self addSubview:self.indicatorView];
    self.backgroundColor = [UIColor clearColor];
    self.bounces = YES;
}

- (void) setSelectedIndexAnimated:(NSUInteger)selectedIndex
{
    
    
    //这句已经表明哪个按钮被选中
    self.selectedIndex = selectedIndex;
    for (UIButton * button in self.buttonArray) {
        button.selected = NO;
    }
    self.selectedButton.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        
        
        
        CGPoint point = CGPointMake(self.selectedButton.x + self.selectedButton.width * 0.5, self.height - 2);
        self.indicatorView.center = point;
        
    } completion:^(BOOL finished) {
        
        CGRect  rect = [self  convertRect: CGRectMake(self.selectedButton.frame.origin.x-self.frame.size.width/2, self.selectedButton.frame.origin.y, self.frame.size.width, self.selectedButton.frame.size.height) toView:self];
        [self scrollRectToVisible:rect  animated:YES];
        
        
        
    }];
    
    
    if (self.delegates && [self.delegates respondsToSelector:@selector(headerView:selectedIndexChanged:)]) {
        
        [self.delegates  headerView:self selectedIndexChanged:selectedIndex];
        
        
    }
    
    
}

//- (void)willMoveToSuperview:(UIView *)newSuperview{
//
//    self.frame = CGRectMake(SCREEN_WIDTH - 150, 10, 150, 45);
//    
//}

@end
