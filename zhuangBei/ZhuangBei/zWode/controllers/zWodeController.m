//
//  zWodeController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zWodeController.h"
#import "zUserInfoCard.h"

@interface zWodeController ()

@property(strong,nonatomic)zUserInfoCard * userinfoCard;

@end

@implementation zWodeController

-(zUserInfoCard*)userinfoCard
{
    if (!_userinfoCard) {
        _userinfoCard = [[zUserInfoCard alloc]init];
        _userinfoCard.layer.cornerRadius = kWidthFlot(5);
        _userinfoCard.layer.borderWidth = 1;
        _userinfoCard.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _userinfoCard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.userinfoCard];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userinfoCard.myNumbers = @"100";
    });
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.userinfoCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(KstatusBarHeight + 44);
        make.height.mas_equalTo(kWidthFlot(200));
    }];
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
