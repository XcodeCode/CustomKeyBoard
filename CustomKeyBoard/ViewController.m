//
//  ViewController.m
//  CustomKeyBoard
//
//  Created by 靳峰 on 16/2/18.
//  Copyright © 2016年 靳峰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) UITextField  *textField;
@property(nonatomic,strong) UIView *keyView;
@property(nonatomic,assign) BOOL isAppear;
@property(nonatomic,assign) BOOL isCustomInput;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //输入框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    self.textField.placeholder = @"请输入你的账号";
    [self.view addSubview:self.textField];
    self.textField.borderStyle =UITextBorderStyleRoundedRect;
    
    //呼入呼出(为了调试)
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor = [UIColor  blackColor];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    
    //键盘区
    UIButton *keyView
    = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40)];
    keyView.backgroundColor = [UIColor grayColor];
    [keyView setTitle:@"键盘区" forState:UIControlStateNormal];
    [keyView addTarget:self action:@selector(changgeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keyView];
    self.keyView = keyView;
    
    //添加键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
//键盘呼入
-(void)keyboardWillAppear:(NSNotification *)noti
{
    //拿到键盘最终frame
    CGRect  rect  = [[noti.userInfo valueForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    NSLog(@"%f",rect.origin.y);
//    [UIView animateWithDuration:0.25 animations:^{
        self.keyView.frame = CGRectMake(0, rect.origin.y-40, self.keyView.frame.size.width, self.keyView.frame.size.height);
//    }];
}
-(void)keyboardWillDisappear:(NSNotification *)noti
{
    //取消键盘,键盘区复位(可以看成代理方法的点击return)
    if (!self.isAppear) {
        [UIView animateWithDuration:0.25 animations:^{
            self.keyView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, self.keyView.frame.size.width, self.keyView.frame.size.height);
        }];
    }
}
//键盘的呼入呼出
-(void)click
{
    self.isAppear = !self.isAppear;
    if (self.isAppear) {
        [self.textField becomeFirstResponder];
    }else{
        [self.textField resignFirstResponder];
    }
    
}
//点击键盘区切换键盘
-(void)changgeKeyBoard
{
    self.isCustomInput = !self.isCustomInput;
    [self.textField resignFirstResponder];
    //是否为自定义键盘
    if (self.isCustomInput) {
        UIView *v  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
        v.backgroundColor = [UIColor orangeColor];
        self.textField.inputView = v;
    }else{
        self.textField.inputView = nil;
    }
    
    [self.textField becomeFirstResponder];
}
@end

