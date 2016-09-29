//
//  FFRootViewController.m
//  FFBanner
//
//  Created by 张玲玉 on 16/9/29.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFRootViewController.h"
#import "FFBannerDetailController.h"
#import "FFBannerCell.h"
#import "FFBannerModel.h"

@interface FFRootViewController ()

@property(nonatomic,strong)NSMutableArray *iconModels;

@end

@implementation FFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.iconModels=[NSMutableArray array];
    for (int i=0; i<7; i++) {
        FFBannerModel *model=[[FFBannerModel alloc]init];
        model.icon=[NSString stringWithFormat:@"icon_%i.jpg",i];
        [self.iconModels addObject:model];
    }
}

#pragma - mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"cell";
    FFBannerCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[FFBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.iconModels=self.iconModels;
    return cell;
}

#pragma - mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFFBannerCell_Height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFBannerDetailController *vc=[[FFBannerDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
