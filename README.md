# LGLAlertView
> 调用的方法
```
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

```
