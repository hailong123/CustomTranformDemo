//
//  TwoViewController.h
//  CustomTranformDemo
//
//  Created by 123456 on 2016/11/30.
//  Copyright © 2016年 KuXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoViewController : UIViewController

@property (nonatomic, strong) UIView       *navgationView;     //类似导航的视图
@property (nonatomic, strong) UITableView  *tableView;        //下面的list列表
@property (nonatomic, strong) UIScrollView *photosScrollView;//上面的图片列表

@end
