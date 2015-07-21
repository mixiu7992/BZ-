//
//  BZOAuthController.m
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZOAuthController.h"
#import "BZNewFeatureController.h"
#import "BZTabBarcontroller.h"
#import "AFNetworking.h"
#import "BZAccountTool.h"

@interface BZOAuthController ()<UIWebViewDelegate>

@end

@implementation BZOAuthController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    //参数client_id	redirect_uritrue	string	申请应用时分配的AppKey。
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=22147293&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if(range.length){
        NSString *code = [url substringFromIndex:(range.location + range.length)];
        [self accessTokenWith:code];
        return NO;
    }
    return YES;
}

- (void)accessTokenWith:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr= [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"22147293";
    params[@"client_secret"] = @"548ee54a612154a49d32bc4cb3874dcd";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        BZAccount *account = [BZAccount accountWithDict:responseObject];
        account.creatDate = [NSDate date];
        [BZAccountTool saveAccount:account];
        //归档后跳转页面
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window changeRootViewController];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BZLog(@"失败%@",error);
    }];
    
}
@end
