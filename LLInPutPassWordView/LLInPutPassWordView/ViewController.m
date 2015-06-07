//
//  ViewController.m
//  LLInputPassWordView
//
//  Created by 李龙 on 15/5/17.
//  Copyright (c) 2015年 Lauren. All rights reserved.
//

#import "ViewController.h"
#import "LLINputPassWordView.h"
#define LLInPutPWView [LLINputPassWordView getSharedInPutPassWordView]
#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

    @interface ViewController ()<UITextFieldDelegate>{
    NSString *withdrawalMoeny; //用于存储输入密码的全局变量
}
@property (weak, nonatomic) IBOutlet UITextField *withdrawalAmount;

@end


@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //金额输入框的代理
    self.withdrawalAmount.delegate = self;
    
    //获取INputPassWordView的输入
    [LLInPutPWView returnText:^(NSString *pwString) {
        NSLog(@"Block返回的输入的密码是:%@",pwString);
        withdrawalMoeny = pwString;
    }];
    

    // 取消当前view
    [LLInPutPWView canncelShowInputPWView:^{
        [LLInPutPWView dismiss];
    }];
 
}


- (IBAction)submitBtnonClick:(id)sender {
    //判断输入框输入的金额是否符合规范,这里不能为0
    //判断输入的金额是否为0.00元
    NSLog(@"--:%@",_withdrawalAmount.text);
    float checkMoney = [_withdrawalAmount.text floatValue];
    if (checkMoney == 0.00 || _withdrawalAmount.text == nil) {
        UIAlertView *warnAlert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请输入大于\"0.00\"元的提款金额" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [warnAlert show];
        return;
    }
    
    //记录输入的金额
    withdrawalMoeny = [NSString stringWithFormat:@"%.2f",checkMoney];
    NSLog(@"输入的金-额:%@",withdrawalMoeny);
    
    //显示输入的
    [LLInPutPWView show];
}


-(void)checkMoney{

}

#pragma mark 键盘输入监听事件,判断输入的金额
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs;
    NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
    if (NSNotFound == nDotLoc && 0 != range.location) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
    }
    else {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
    }
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
        NSLog(@"只能输入数字和小数点");
        return NO;
    }
    if (NSNotFound != nDotLoc && range.location > nDotLoc + 2) { //这里可以改三位
        NSLog(@"小数点后最多两位");
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
