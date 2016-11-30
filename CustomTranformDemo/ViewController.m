
//
//  ViewController.m
//  CustomTranformDemo
//
//  Created by 123456 on 2016/11/30.
//  Copyright © 2016年 KuXing. All rights reserved.
//

#import "ViewController.h"

#import "TwoViewController.h"

@interface ViewController () {
    
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //创建视图
    [self createUI];
    
}


#pragma mark -Private Method
- (void)createUI {
    
    _imgView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"001"]];
    _imgView.contentMode            = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds          = YES;
    _imgView.userInteractionEnabled = YES;
    [self.view addSubview:_imgView];
    
    //跳转
    [_imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump:)]];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
        make.width.height.equalTo(self.view.mas_width).multipliedBy(0.8);
        
    }];
    
}

- (void)jump:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _imgView.transform  = CGAffineTransformScale(_imgView.transform, 1.25, 1.25);
        self.view.transform = CGAffineTransformScale(self.view.transform, 0.8, 0.8);
        
    } completion:^(BOOL finished) {
        
        [self presentViewController:[TwoViewController new] animated:YES completion:nil];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
