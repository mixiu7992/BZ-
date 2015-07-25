//
//  BZComposeController.m
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZComposeController.h"
#import "BZAccountTool.h"
#import "BZComposeTextView.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "BZComposeToolBar.h"
#import "BZComposePhotosView.h"
#import "BZEmotionKeyboard.h"


@interface BZComposeController ()<UITextViewDelegate,BZComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) BZComposeTextView *textView;
@property (nonatomic,weak) BZComposeToolBar *toolBar;
@property (nonatomic,weak) BZComposePhotosView *photosView;
@property (nonatomic,assign) BOOL isSwitchEmotion;

@end

@implementation BZComposeController
#pragma mark - 系统方法
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏按钮
    [self setupNav];
    
    [self setupTitleView];
    
    [self setupTextView];
    
    [self setupToolBar];
    
    BZComposePhotosView *photosView = [[BZComposePhotosView alloc] init];
    photosView.frame = self.view.bounds;
    photosView.y = 100;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //不可用状态得在生命周期函数里设置才有效
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.textView becomeFirstResponder];

}
#pragma mark - 初始化方法

- (void)setupToolBar
{
    BZComposeToolBar *toolBar = [[BZComposeToolBar alloc] init];
    toolBar.height = 44;
    toolBar.width = self.view.width;
    toolBar.x = 0;
    toolBar.y = self.view.height - toolBar.height;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
}

- (void)setupTitleView
{
    UILabel *title = [[UILabel alloc] init];
    title.height = 40;
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    NSString *prefix = @"发微博";
    NSString *name = [BZAccountTool account].name;
    NSString *fix = [NSString stringWithFormat:@"%@\n%@",prefix,name ? name:@""];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:fix];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    [str addAttributes:attrs range:[fix rangeOfString:prefix]];
    
    NSMutableDictionary *attrsName = [NSMutableDictionary dictionary];
    attrsName[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [str addAttributes:attrsName range:[fix rangeOfString:name]];
    
    title.attributedText = str;
    self.navigationItem.titleView = title;
}

- (void)setupTextView
{
    BZComposeTextView *textView = [[BZComposeTextView alloc] init];
    textView.width = self.view.width;
    textView.height = self.view.height;
    textView.delegate = self;
    textView.placeholder = @"分享你的新鲜事...";
    [BZNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:textView];
    [BZNotificationCenter addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.view addSubview:textView];
    self.textView = textView;
}

#pragma mark - 监听方法
- (void)keyboardChange:(NSNotification *)notification
{
    if (self.isSwitchEmotion) return;
    NSDictionary *userInfo =  notification.userInfo;
    CGRect keyF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:[userInfo[UIKeyboardAnimationDurationUserInfoKey] integerValue] animations:^{
        self.toolBar.y = keyF.origin.y - self.toolBar.height;
    }];
   
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)send
{
    if (self.photosView.subviews.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
}
- (void)sendWithoutImage
{
    
    //https://api.weibo.com/2/statuses/update.json access_token status
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [BZAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showInfoWithStatus:@"发表成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithImage
{
    UIImage *image = [[self.photosView.subviews firstObject] image];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [BZAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1.0) name:@"pic" fileName:@"1.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发表成功" maskType:SVProgressHUDMaskTypeGradient];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误" maskType:SVProgressHUDMaskTypeGradient];
    }];
    [self  dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textview代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - toolbar的代理方法
- (void)toolBar:(BZComposeToolBar *)toolBar DidClinkButtonType:(BZComposeToolBarButtonType)buttonType
{
    switch (buttonType) {
        case BZComposeToolBarButtonTypeCarema:
            [self chooseImageWith:UIImagePickerControllerSourceTypeCamera];
            break;
        case BZComposeToolBarButtonTypePhoto:
            [self chooseImageWith:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case BZComposeToolBarButtonTypeMention:
            
            break;
        case BZComposeToolBarButtonTypeTrend:
            
            break;
        case BZComposeToolBarButtonTypeEmotion:
            [self changeEmotionKeyboard];
            break;
        
    }
}

- (void)changeEmotionKeyboard
{
    self.isSwitchEmotion = YES;
    if (self.textView.inputView == nil) {
        self.toolBar.isKeyboard = NO;
        BZEmotionKeyboard *emotionKeyboard = [[BZEmotionKeyboard alloc] init];
        emotionKeyboard.height = 216;
        emotionKeyboard.width = self.view.width;
        self.textView.inputView = emotionKeyboard;
    }else{
        self.toolBar.isKeyboard = YES;
        self.textView.inputView = nil;
    }
    [self.view endEditing:YES];
    [self.textView becomeFirstResponder];
    self.isSwitchEmotion = NO;

}

- (void)chooseImageWith:(UIImagePickerControllerSourceType)sourcType
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourcType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - imagePicker代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView saveImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
