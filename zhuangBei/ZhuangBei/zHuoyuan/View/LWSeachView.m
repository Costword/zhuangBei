//
//  LWSeachView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWSeachView.h"

@implementation LWSeachView

+ (instancetype)seachview:(callBlock)block
{
    LWSeachView *search = [[LWSeachView alloc] init];
    search.block = block;
    return search;
}

- (void)clickBtn
{
    if (self.block) {
        self.block(1, @"");
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *backbtn = [UIButton new];
        [backbtn setImage:IMAGENAME(@"return_btn") forState:UIControlStateNormal];
        [backbtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UITextField *tf = [UITextField new];
        tf.placeholder = @"搜索";
        tf.backgroundColor = UIColor.clearColor;
        tf.delegate = self;
        tf.font = kFont(14);
        UIView *tfbg = [UIView new];
        tfbg.backgroundColor = UIColor.grayColor;
        tfbg.alpha = 0.3;
        
        [self addSubviews:@[backbtn,tfbg,tf]];
        [backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.height.mas_offset(40);
        }];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tfbg.mas_left).mas_offset(8);
            make.right.mas_equalTo(tfbg.mas_right).mas_offset(-8);
            make.centerY.mas_equalTo(tfbg.mas_centerY);
            make.height.mas_offset(30);
        }];
        [tfbg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(backbtn.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.mas_right).mas_offset(-25);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(34);
        }];
        [tfbg setBoundWidth:0 cornerRadius:17 boardColor:UIColor.grayColor];
        _tf = tf;
        tf.returnKeyType = UIReturnKeySearch;//变为搜索按钮
        [tf becomeFirstResponder];
    }
    return self;
}
//搜索虚拟键盘响应

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tf resignFirstResponder];
    if (self.block) {
        self.block(2, textField.text);
    }
      return YES;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
////    if (self.block) {
////        self.block(2, str);
////    }
//    return YES;
//}
@end
