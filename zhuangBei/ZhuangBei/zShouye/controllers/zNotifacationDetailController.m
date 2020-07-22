//
//  zNotifacationDetailController.m
//  ZhuangBei
//  通知公告详情页
//  Created by aa on 2020/7/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zNotifacationDetailController.h"

@interface zNotifacationDetailController ()

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UILabel *timeLabel;

@property(strong,nonatomic)UILabel *personLabel;

@property(strong,nonatomic)UILabel *messageLabel;

@property(strong,nonatomic)UIButton *backButton;

@end

@implementation zNotifacationDetailController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"通知公告详情";
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kFont(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = kFont(12);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}


-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = kFont(12);
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

-(UIButton*)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc]init];
        _backButton.backgroundColor = [UIColor blueColor];
        [_backButton setTitle:@"平台公告" forState:UIControlStateNormal];
        _backButton.titleLabel.font = kFont(12);
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backButton.layer.cornerRadius = kWidthFlot(2);
        _backButton.clipsToBounds = YES;
    }
    return _backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.backButton];
    [self loadData];
}

-(void)loadData{
    [self requestPostWithUrl:klistAndUpdate paraString:@{@"gongGaoDm":self.gongGaoDm} success:^(id  _Nonnull response) {
        
        NSLog(@"通知公告详情%@",response);
        NSDictionary * appNotice = response[@"appNotice"];
        self.titleLabel.text = appNotice[@"gongGaoBt"];
        self.timeLabel.text = appNotice[@"chuangJianSj"];
        self.messageLabel.text = appNotice[@"gongGaoNr"];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(10));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(10));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kWidthFlot(5));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel.mas_right).offset(kWidthFlot(5));
        make.centerY.mas_equalTo(self.timeLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(10));
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(kWidthFlot(5));
        make.right.mas_equalTo(-kWidthFlot(10));
    }];
}




@end
