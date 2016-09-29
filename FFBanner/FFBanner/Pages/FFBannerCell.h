//
//  FFBannerCell.h
//  FFBanner
//
//  Created by 张玲玉 on 16/3/10.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FFBannerModel.h"
#import "UIView+WBJobExtension.h"

#define kFFBannerCell_Height kMainScreen_Height-62

@protocol QHBannerViewDelegate <NSObject>

- (void)bannerClicked:(FFBannerModel *)model;

@end

@interface FFBannerCell : UITableViewCell

@property(nonatomic,assign)id<QHBannerViewDelegate> delegate;
@property(nonatomic,strong)NSMutableArray *iconModels;

@end
