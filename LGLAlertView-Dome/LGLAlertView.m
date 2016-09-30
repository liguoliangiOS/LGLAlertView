//
//  LGLAlertView.m
//  LGLAlertView-Dome
//
//  Created by 李国良 on 2016/9/29.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import "LGLAlertView.h"
#define  LGLAlertShowTime 1.0

@implementation LGLAlertView

// ======================================================================== ----- AlertView start----- ==================================================================================

// 单个或没有按钮

+ (void)showAlertViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)btnTitle buttonStyle:(LGLAlertViewActionStyle)buttonStyle {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (btnTitle.length) {
        UIAlertActionStyle actionStyle = (buttonStyle == LGLAlertViewActionStyleDefault) ? UIAlertActionStyleDefault : ((buttonStyle ==  LGLAlertViewActionStyleCancel) ? UIAlertActionStyleCancel : UIAlertActionStyleDestructive);
        UIAlertAction * alertAction = alertAction = [UIAlertAction actionWithTitle:btnTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:LGLAlertShowTime];
        }];;
        [alertController addAction:alertAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
    } else {
        [viewController presentViewController:alertController animated:YES completion:nil];
        [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:LGLAlertShowTime];
    }
}

// 单个或多个按钮

+ (void)showAlertViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message CallBackBlock:(CallBackBlock)block cancelButtonTitle:(NSString *)cancelBtnTitle destructiveButtonTitle:(NSString *)destructiveBtnTitle otherButtonTitles:(NSString *)otherBtnTitles,... {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //添加按钮
    if (cancelBtnTitle.length) {
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        [alertController addAction:cancelAction];
    }
    if (destructiveBtnTitle.length) {
        UIAlertAction * destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            block(1);
        }];
        [alertController addAction:destructiveAction];
    }
    if (otherBtnTitles.length) {
        UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherBtnTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            (!cancelBtnTitle.length && !destructiveBtnTitle.length) ? block(0) : (((cancelBtnTitle.length && !destructiveBtnTitle.length) || (!cancelBtnTitle.length && destructiveBtnTitle.length)) ? block(1) : block(2));
        }];
        [alertController addAction:otherActions];
        
        va_list args;
        va_start(args, otherBtnTitles);
        if (otherBtnTitles.length) {
            NSString * otherString;
            int index = 2;
            (!cancelBtnTitle.length && !destructiveBtnTitle.length) ? (index = 0) : ((cancelBtnTitle.length && !destructiveBtnTitle.length) || (!cancelBtnTitle.length && destructiveBtnTitle.length) ? (index = 1) : (index = 2));
            while ((otherString = va_arg(args, NSString*))) {
                index ++ ;
                UIAlertAction * otherActions = [UIAlertAction actionWithTitle:otherString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    block(index);
                }];
                [alertController addAction:otherActions];
            }
        }
        va_end(args);
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
    
    //如果没有按钮，自动延迟消失
    if (!cancelBtnTitle.length && !destructiveBtnTitle.length && !otherBtnTitles) {
        //此时self指本类
        [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:LGLAlertShowTime];
    }
}

// 有输入框

+ (void)showAlertTextFieldViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message TextFeildCallBackBlock:(TextFieldCallBackBlock)textBlock cancelButtonTitle:(NSString *)cancelBtnTitle otherButtonTitles:(NSString *)otherBtnTitle {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
     }];
    if (cancelBtnTitle.length) {
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissAlertController:alertController];
        }];
        [alertController addAction:cancelAction];
    }
    if (otherBtnTitle.length) {
        UIAlertAction * otherAction = [UIAlertAction actionWithTitle:otherBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            textBlock([alertController.textFields firstObject].text);
        }];
        [alertController addAction:otherAction];
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
    //如果没有按钮，自动延迟消失
    if (!cancelBtnTitle.length && !otherBtnTitle.length) {
        //此时self指本类
        [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:LGLAlertShowTime];
    }

}
// ======================================================================== ----- AlertView end----- ==================================================================================
#pragma mark ==== 点击事件 ======
+ (void)dismissAlertController:(UIAlertController *)alert {
    [alert dismissViewControllerAnimated:YES completion:nil];
}

// ======================================================================== -- ActionSheet Start -- ====================================================================================

+ (void)showAlertActionSheetViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)btnTitle buttonStyle:(LGLAlertViewActionStyle)buttonStyle {

     UIAlertController * actionController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (btnTitle.length) {
        UIAlertActionStyle actionStyle = (buttonStyle == LGLAlertViewActionStyleDefault) ? UIAlertActionStyleDefault : ((buttonStyle ==  LGLAlertViewActionStyleCancel) ? UIAlertActionStyleCancel : UIAlertActionStyleDestructive);
        UIAlertAction * alertAction = alertAction = [UIAlertAction actionWithTitle:btnTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
            [self performSelector:@selector(dismissAlertController:) withObject:actionController afterDelay:LGLAlertShowTime];
        }];;
        [actionController addAction:alertAction];
        [viewController presentViewController:actionController animated:YES completion:nil];
    } else {
        [viewController presentViewController:actionController animated:YES completion:nil];
    //如果没有按钮，自动延迟消失
        [self performSelector:@selector(dismissAlertController:) withObject:actionController afterDelay:LGLAlertShowTime];
    }
}

+ (void)showAlertActionSheetWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message callbackBlock:(CallBackBlock)block destructiveButtonTitle:(NSString *)destructiveBtnTitle cancelButtonTitle:(NSString *)cancelBtnTitle otherButtonTitles:(NSString *)otherBtnTitles, ... {
    
    UIAlertController * actionController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    //添加按钮
    if (destructiveBtnTitle.length) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        [actionController addAction:destructiveAction];
    }
    if (cancelBtnTitle.length) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            destructiveBtnTitle.length ? block(1) : block(0);
        }];
        [actionController addAction:cancelAction];
    }
    if (otherBtnTitles.length)
    {
        UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherBtnTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            (!cancelBtnTitle.length && !destructiveBtnTitle.length) ? block(0) : (((destructiveBtnTitle.length && !cancelBtnTitle.length) || (!destructiveBtnTitle.length && cancelBtnTitle.length)) ? block(1) : block(2));
        }];
        [actionController addAction:otherActions];
        
        
        va_list args;
        va_start(args, otherBtnTitles);
        if (otherBtnTitles.length) {
            NSString * otherString;
            int index = 2;
            (!cancelBtnTitle.length && !destructiveBtnTitle.length) ? (index = 0) : ((cancelBtnTitle.length && !destructiveBtnTitle.length) || (!cancelBtnTitle.length && destructiveBtnTitle.length) ? (index = 1) : (index = 2));
            while ((otherString = va_arg(args, NSString*))) {
                index ++ ;
                UIAlertAction * otherActions = [UIAlertAction actionWithTitle:otherString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    block(index);
                }];
                [actionController addAction:otherActions];
            }
        }
        va_end(args);
    }
    [viewController presentViewController:actionController animated:YES completion:nil];
    
    //如果没有按钮，自动延迟消失
    if (!cancelBtnTitle.length && !destructiveBtnTitle.length && !otherBtnTitles.length) {
        //此时self指本类
        [self performSelector:@selector(dismissAlertController:) withObject:actionController afterDelay:LGLAlertShowTime];
    }
    
}
@end
