//
//  FFBannerCell.m
//  FFBanner
//
//  Created by 张玲玉 on 16/3/10.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//

#import "FFBannerCell.h"
#import "FFBannerView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface FFBannerCell ()<UIScrollViewDelegate,FFBannerDelegate>

@property(nonatomic,assign)CGSize size;
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UIPageControl *page;

@property(nonatomic,strong)FFBannerView *leftImage;
@property(nonatomic,strong)FFBannerView *centerImage;
@property(nonatomic,strong)FFBannerView *rightImage;

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation FFBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _scroll=[[UIScrollView alloc]init];
        _scroll.frame=CGRectMake(0, 0, kMainScreen_Width, kFFBannerCell_Height);
        _scroll.delegate=self;
        _scroll.pagingEnabled=YES;
        _scroll.showsHorizontalScrollIndicator=NO;
        _scroll.contentSize=CGSizeMake(kMainScreen_Width*3, 0);
        _scroll.backgroundColor=[UIColor grayColor];
        [self addSubview:_scroll];
   
        _page=[[UIPageControl alloc]init];
        _page.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.2];
        _page.userInteractionEnabled=NO;
        [self addSubview:_page];
        [_page mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_scroll.mas_bottom).with.offset(0);
            make.left.right.equalTo(@(0));
            make.height.equalTo(@(40));
        }];
        
        _leftImage=[[FFBannerView alloc]init];
        _leftImage.backgroundColor=[UIColor yellowColor];
        _rightImage=[[FFBannerView alloc]init];
        _rightImage.backgroundColor=[UIColor orangeColor];
        _centerImage=[[FFBannerView alloc]init];
        _centerImage.backgroundColor=[UIColor magentaColor];
        NSArray *array=@[_leftImage,_centerImage,_rightImage];
        for (int i=0; i<array.count; i++) {
            UIImageView *item=array[i];
            item.frame=CGRectMake(i*kMainScreen_Width, 0, kMainScreen_Width,kFFBannerCell_Height);
            [_scroll addSubview:item];
        }
    }
    return self;
}

- (void)setIconModels:(NSMutableArray *)iconModels
{
    _iconModels=iconModels;
    _count=iconModels.count;
    
    _page.numberOfPages=_count;
    _page.currentPage=0;
    
    [self changeImageLeft:_count-1 center:0 right:1];
    [self startTiming];
}

#pragma - mark 轮播

- (void)changeImageLeft:(NSInteger)leftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex
{
    FFBannerModel *leftModel=_iconModels[leftIndex];
    FFBannerModel *centerModel=_iconModels[centerIndex];
    FFBannerModel *rightModel=_iconModels[rightIndex];
    
    _leftImage.image=[UIImage imageNamed:leftModel.icon];
    _centerImage.image=[UIImage imageNamed:centerModel.icon];
    _rightImage.image=[UIImage imageNamed:rightModel.icon];
    
    [_scroll setContentOffset:CGPointMake(kMainScreen_Width, 0)];
}

- (void)changeImageOffset:(CGFloat)offset
{
    if (offset >= kMainScreen_Width*2) {
        _index++;
        if (_index == _count) {
            _index = 0;
            [self changeImageLeft:_count-1 center:0 right:1];
        }
        else if (_index == _count-1) {
            [self changeImageLeft:_index-1 center:_index right:0];
        }
        else {
            [self changeImageLeft:_index-1 center:_index right:_index+1];
        }
    }
    if (offset<=0) {
        _index--;
        if (_index == 0) {
            [self changeImageLeft:_count-1 center:0 right:1];
        }
        else if (_index == -1) {
            _index = _count-1;
            [self changeImageLeft:_index-1 center:_index right:0];
        }
        else {
            [self changeImageLeft:_index-1 center:_index right:_index+1];
        }
    }
    _page.currentPage = _index;
}

#pragma - mark Timer

- (void)startTiming
{
    if (_timer==nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrolling) userInfo:nil repeats:YES];
    }
}

- (void)scrolling
{
    [_scroll setContentOffset:CGPointMake(_scroll.contentOffset.x + kMainScreen_Width, 0) animated:YES];
}

- (void)stopTiming
{
    [_timer invalidate];
    _timer = nil;
}

#pragma - mark UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTiming];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTiming];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeImageOffset:scrollView.contentOffset.x];
}

#pragma - mark QHBannerDelegate

- (void)bannerClicked:(FFBannerModel *)model
{
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(bannerClicked:)]) {
        [self.delegate bannerClicked:model];
    }
}

@end
