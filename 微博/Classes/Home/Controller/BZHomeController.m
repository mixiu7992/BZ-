//
//  BZHomeController.m
//  微博
//
//  Created by 白斌 on 15/7/18.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZHomeController.h"
#import "UIBarButtonItem+Extention.h"
#import "BZDropDownMenu.h"
#import "BZTitleButton.h"
#import "AFNetworking.h"
#import "BZAccountTool.h"
#import "UIImageView+WebCache.h"
#import "BZStatus.h"
#import "MJExtension.h"
#import "BZStatusFrame.h"
#import "BZStatusCell.h"

@interface BZHomeController ()<BZDropDownMenuDelegate>

@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation BZHomeController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTitileBtn];
    
    [self setupUserInfo];
    
//    [self getNewStatuses];
    //下拉刷新
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(downRefreshStatuses:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:refresh];
    [refresh beginRefreshing];
    [self downRefreshStatuses:refresh];
    //显示未读多少条消息
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(unreadCountStatus) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

//未读消息数目
- (void)unreadCountStatus
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    BZAccount *account = [BZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSString *unreadStatus = [responseObject[@"status"] description];
        if ([unreadStatus isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = unreadStatus;
            [UIApplication sharedApplication].applicationIconBadgeNumber = [unreadStatus intValue];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)downRefreshStatuses:(UIRefreshControl *)refresh
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    BZAccount *account = [BZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"count"] = @1;
    //拿到当前微博数组里的最新微博的ID 发送给服务器  取得比当前最新微博ID更大得微博数据
    BZStatusFrame *statusFrame = [self.statusFrames firstObject];
    if (statusFrame) {
        params[@"since_id"] = statusFrame.status.idstr;
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@",responseObject[@"statuses"]);
        NSArray *newStatuses = [BZStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (BZStatus *status in newStatuses) {
            BZStatusFrame *statusFrame = [[BZStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrames addObject:statusFrame];
        }
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:statusFrames atIndexes:set];
        [self.tableView reloadData];
        [refresh endRefreshing];
        
        //弹出提示刷新了多少数据
        [self refreshCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [refresh endRefreshing];
    }];
}

/**  顶部弹出刷新了多少微博  */
- (void)refreshCount:(long long)count
{
    UILabel *countLabel = [[UILabel alloc] init];
    if (count == 0 ) {
        countLabel.text = @"没有新的微博";
    }else
    {
        countLabel.text = [NSString stringWithFormat:@"有%lld条新微博",count];
    }
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    countLabel.width = [UIScreen mainScreen].bounds.size.width;
    countLabel.height = 35;
    countLabel.y = 64 - countLabel.height;
    [self.navigationController.view insertSubview:countLabel belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1.0 animations:^{
        countLabel.transform = CGAffineTransformMakeTranslation(0, countLabel.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            countLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [countLabel removeFromSuperview];
        }];
    }];
}

//- (void)getNewStatuses
//{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [BZAccountTool account].access_token;
//    params[@"count"] = @10;
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //用框架直接字典数组转换成模型数组
//        self.statuses = [BZStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}

- (void)setupUserInfo
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    BZAccount *account = [BZAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        account.name = responseObject[@"name"];
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:account.name forState:UIControlStateNormal];
        [BZAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setupTitileBtn
{
    BZTitleButton *titleBtn = [[BZTitleButton alloc] init];
    NSString *name = [BZAccountTool account].name;
    [titleBtn setTitle:name?name :@"首页" forState:UIControlStateNormal];
    
    [titleBtn addTarget:self action:@selector(dropMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
}

- (void)dropMenu:(UIButton *)button
{
    BZDropDownMenu *menu = [BZDropDownMenu dropMenu];
    menu.delegate = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(0, 0, 200, 300);
    menu.contentView = btn;
    
    [menu showWith:button];
}

- (void)friendSearch
{
    NSLog(@"%s",__func__);
}

- (void)pop
{
    NSLog(@"%s",__func__);

}
#pragma mark - dropDownMenu代理实现
- (void)dropDownMenuDidFinishShow:(BZDropDownMenu *)menu
{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
}

- (void)dropDownMenuDidFinishDimiss:(BZDropDownMenu *)menu
{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = NO;
}
#pragma mark - tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BZStatusCell *cell = [BZStatusCell statusCellWithTableView:tableView];
    
    
    BZStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    cell.statusFrame = statusFrame;
    
    return cell;
}

#pragma mark - tableview代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BZStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}
@end
