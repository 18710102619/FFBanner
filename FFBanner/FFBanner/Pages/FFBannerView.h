//
//  QHBanner.h
//  WBQuickToHire
//
//  Created by 张玲玉 on 16/3/11.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFBannerModel.h"

@protocol FFBannerDelegate <NSObject>

- (void)bannerClicked:(FFBannerModel *)model;

@end

@interface FFBannerView : UIImageView

@property(nonatomic,assign)id<FFBannerDelegate> delegate;
@property(nonatomic,strong)FFBannerModel *model;

@end
