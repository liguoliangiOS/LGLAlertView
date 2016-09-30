//
//  ViewController.m
//  LGLAlertView-Dome
//
//  Created by 李国良 on 2016/9/29.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import "ViewController.h"
#import "LGLAlertView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * alertAddButn = [UIButton buttonWithType:UIButtonTypeCustom];
    alertAddButn.frame = CGRectMake(200, 300, 100, 40);
    [alertAddButn setTitle:@"展示" forState:UIControlStateNormal];
    [alertAddButn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [alertAddButn setBackgroundColor:[UIColor blueColor]];
    [alertAddButn addTarget:self action:@selector(alertActionClink) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertAddButn];
    
}

- (void)alertActionClink {
    // LGLAlertViewActionStyleDestructive     LGLAlertViewActionStyleDefault   LGLAlertViewActionStyleCancel
   // [LGLAlertView showAlertViewWith:self title:@"温馨提示" message:@"操作成功" buttonTitle:@"知道了" buttonStyle:LGLAlertViewActionStyleDefault];
    /*[LGLAlertView showAlertViewWith:self title:@"温馨提示" message:@"操作成功" CallBackBlock:^(NSInteger btnIndex) {
        NSLog(@"%ld", btnIndex);
    } cancelButtonTitle:@"取消" destructiveButtonTitle:@"撤销" otherButtonTitles:@"确定", @"666", @"777",nil];*/
   /* [LGLAlertView showAlertTextFieldViewWith:self title:nil message:@"您的宝贵意见" TextFeildCallBackBlock:^(NSString *text) {
        NSLog(@"%@", text);
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];*/
    
    //[LGLAlertView showAlertActionSheetViewWith:self title:@"2222" message:@"6666" buttonTitle:nil buttonStyle:LGLAlertViewActionStyleDestructive];
    [LGLAlertView showAlertActionSheetWith:self title:nil message:nil callbackBlock:^(NSInteger btnIndex) {
        NSLog(@"%ld", btnIndex);
    } destructiveButtonTitle:nil cancelButtonTitle:nil otherButtonTitles:@"确定", @"wed", @"dfd", @"rtfgb", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
