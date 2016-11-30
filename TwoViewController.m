//
//  TwoViewController.m
//  CustomTranformDemo
//
//  Created by 123456 on 2016/11/30.
//  Copyright © 2016年 KuXing. All rights reserved.
//

#import "TwoViewController.h"

#import "HLCustomTrantions.h"

@interface TwoViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
UIViewControllerTransitioningDelegate
>
{
    UIPageControl *_pageControl;//页码
}

@end

@implementation TwoViewController

#pragma mark - ViewCycle

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.transitioningDelegate  = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //创建视图
    [self createUI];

    //设置数据源
    [self dataSources];
}

#pragma mark - Delegate
//MARK:UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.text      = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}

//MARK:UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 100) {
        
        CGFloat currentPageNumber = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
        
        _pageControl.currentPage  = currentPageNumber;
    }
    
}

//UIViewTransitionDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    return [HLCustomTrantions transitionWithType:HLTransitionTypeDismiss];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    return [HLCustomTrantions transitionWithType:HLTransitionTypePersent];
}

#pragma mark -Private Methord

//创建视图
- (void)createUI {
    
    self.view.backgroundColor = [UIColor blueColor];
    
    //类似导航的视图
    _navgationView                 = [[UIView alloc] init];
    _navgationView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_navgationView];
    
    [_navgationView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.3);
        
    }];
    
    
    //图片视图
    _photosScrollView                 = [[UIScrollView alloc] init];
    _photosScrollView.tag             = 100;
    _photosScrollView.delegate        = self;
    _photosScrollView.pagingEnabled   = YES;
    _photosScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_photosScrollView];
    
    [_photosScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(70);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.8);
        
    }];
    
    //PageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.view addSubview:_pageControl];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@20);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(_photosScrollView).offset(-15);
        
    }];
    
    //下边的表格视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.tag        = 200;
    _tableView.rowHeight  = 50;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.top.equalTo(_photosScrollView.mas_bottom);
        
    }];
}


//设置数据源
- (void)dataSources {

    //页码
    _pageControl.numberOfPages = 7;
    
    //滚动视图的内容大小
    [_photosScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame) * 7, 0)];
    
    //设置滚动视图的图片
    @autoreleasepool {
        
        for (NSInteger i = 1; i <= 7; i++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"00%ld",(long)i]]];
            imgView.contentMode  = UIViewContentModeScaleAspectFill;
            imgView.frame        = CGRectMake(CGRectGetWidth(self.view.frame) * (i-1), 0,
                                       CGRectGetWidth(self.view.frame),
                                       CGRectGetHeight(self.view.frame)*0.3);
            
            [_photosScrollView addSubview:imgView];
        }
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
