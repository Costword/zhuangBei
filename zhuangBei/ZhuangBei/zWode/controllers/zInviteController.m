//
//  zInviteController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/4.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zInviteController.h"
#import "zEducationRankTypeInfo.h"
#import <AFNetworking.h>
#import "JShareApp.h"
#import "zEducationRankTypeInfo.h"

@interface zInviteController ()

@property(strong,nonatomic)UILabel * titleLabel;

@property(strong,nonatomic)UIButton * inviteNumBtn;

@property(strong,nonatomic)UILabel * descLabel;

@property(strong,nonatomic)UIImageView * inviteImageView;

@property(strong,nonatomic)UILabel * shareLabel;

@property(strong,nonatomic)UIButton * QQShareBtn;

@property(strong,nonatomic)UIButton * WXShareBtn;

@end

@implementation zInviteController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"我的邀请码";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _titleLabel.font = kFont(26);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UIButton*)inviteNumBtn
{
    if (!_inviteNumBtn) {
        _inviteNumBtn = [[UIButton alloc]init];
        _inviteNumBtn.titleLabel.font = kFont(48);
        [_inviteNumBtn setTitleColor:[UIColor colorWithHexString:@"#3F50B5"] forState:UIControlStateNormal];
        [_inviteNumBtn setTitle:[zUserInfo shareInstance].userInfo.invatationCode forState:UIControlStateNormal];
        _inviteNumBtn.clipsToBounds = YES;
        _inviteNumBtn.tag = 1;
        [_inviteNumBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inviteNumBtn;
}
-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _descLabel.text = @"点击邀请码进行复制";
        _descLabel.font = kFont(16);
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

-(UIImageView*)inviteImageView
{
    if (!_inviteImageView) {
        _inviteImageView = [[UIImageView alloc]init];
        _inviteImageView.image = [UIImage imageNamed:@"storeIMage"];
        _inviteImageView.contentMode = UIViewContentModeScaleAspectFit;
        _inviteImageView.alpha = 1;
        _inviteImageView.backgroundColor = [UIColor whiteColor];
    }
    return _inviteImageView;
}

-(UILabel*)shareLabel
{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.text = @"分享至:";
        _shareLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _shareLabel.font = kFont(16);
        _shareLabel.numberOfLines = 0;
        _shareLabel.alpha = 1;
    }
    return _shareLabel;
}

-(UIButton*)QQShareBtn
{
    if (!_QQShareBtn) {
        _QQShareBtn = [[UIButton alloc]init];
        [_QQShareBtn setImage:[UIImage imageNamed:@"QQ_Share"] forState:UIControlStateNormal];
//        _QQShareBtn.layer.cornerRadius = kWidthFlot(25);
        _QQShareBtn.clipsToBounds = YES;
        _QQShareBtn.tag = 2;
        [_QQShareBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _QQShareBtn.alpha = 1;
    }
    return _QQShareBtn;
}

-(UIButton*)WXShareBtn
{
    if (!_WXShareBtn) {
        _WXShareBtn = [[UIButton alloc]init];
        [_WXShareBtn setImage:[UIImage imageNamed:@"WX_Share"] forState:UIControlStateNormal];
        _WXShareBtn.clipsToBounds = YES;
        _WXShareBtn.tag = 3;
        [_WXShareBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _WXShareBtn.alpha = 1;
    }
    return _WXShareBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.inviteNumBtn];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.inviteImageView];
    [self.view addSubview:self.shareLabel];
    [self.view addSubview:self.QQShareBtn];
    [self.view addSubview:self.WXShareBtn];
    NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,getShareImage];
    
    if ([zEducationRankTypeInfo shareInstance].userInfoModel == nil) {
        NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kgetUserInfo];
        [self postDataWithUrl:url WithParam:nil];
    }
    
    [self.inviteImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}






-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(20);
    }];
    
    [self.inviteNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(67);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.inviteNumBtn.mas_bottom).offset(15);
    }];
    
    [self.inviteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kWidthFlot(10));
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3));
    }];
    
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.inviteImageView.mas_left).offset(-2);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.inviteImageView.mas_bottom).offset(kWidthFlot(10));
    }];
    
    [self.QQShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(-kWidthFlot(28));
        make.top.mas_equalTo(self.shareLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50,50));
    }];
    
    [self.WXShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX).offset(kWidthFlot(28));
        make.top.mas_equalTo(self.shareLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}


-(void)buttonClick:(UIButton*)button
{
    if (button.tag == 1) {
        NSString * message = [self.inviteNumBtn currentTitle];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = message;
        NSString * hudMessage = [NSString stringWithFormat:@"已复制邀请码至剪切板%@",message];
        [[zHud shareInstance]showMessage:hudMessage];
        return;
    }
    
    if (button.tag == 2) {
//        [[zHud shareInstance]showMessage:@"分享QQ"];
        [self shareQQ];
        return;
    }
    
    if (button.tag == 3) {
//        [[zHud shareInstance]showMessage:@"分享微信"];
        [self shareWX];
        return;
    }
}

-(void)shareQQ{
    NSString *url = [[NSBundle mainBundle] URLForResource:@"storeIMage" withExtension:@"png"].absoluteString;
    [JShareApp shareImageWithPlatform:JSHAREPlatformQQ imageUrl:url OrImage:self.inviteImageView.image success:^(id  _Nonnull info) {
        
    } fail:^(id  _Nonnull info) {
        
    }];
}

-(void)shareWX{
//    NSString *url = [[NSBundle mainBundle] URLForResource:@"storeIMage" withExtension:@"png"].absoluteString;
    
//https://www.110zhuangbei.com/app/index.html
    NSString * url = [NSString stringWithFormat:@"http://110zhuangbei.com/app/modules/frontend/user/reg.html?refereeId=%ld",[zEducationRankTypeInfo shareInstance].userInfoModel.userDm];
    
    [JShareApp shareWebURLWithPlatform:JSHAREPlatformWechatSession title:[NSString stringWithFormat:@"%@ 诚邀您加入警用行业联盟",[zEducationRankTypeInfo shareInstance].userInfoModel.userName] text:[NSString stringWithFormat:@"邀请码：【%@】，这里是警用行业人的大家庭，十分期待您的加入！点击下载APP",[zUserInfo shareInstance].userInfo.invatationCode] url:url icon:@"" success:^(id  _Nonnull info) {
        
    } fail:^(id  _Nonnull info) {
        NSLog(@"%@",info);
    }];
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:getShareImage]) {
        
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
        return;
    }
    
    if ([url containsString:kgetUserInfo]) {
        [[zHud shareInstance]showMessage:@"获取用户信息失败"];
        return;
    }

}



-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:getShareImage]) {
        NSDictionary * dic = data[@"page"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            
        }
        NSLog(@"公司认证信息%@",dic);
        return;
    }
    
    if ([url containsString:kgetUserInfo]) {
        NSDictionary * dic = data;
        NSString * msg = dic[@"msg"];
        NSString * code = dic[@"code"];
        if ([code integerValue] == 0) {
            //请求成功
            NSDictionary * userInfoDic = dic[@"list"];
            zUserCenterModel * userModel = [zUserCenterModel mj_objectWithKeyValues:userInfoDic];
            [zEducationRankTypeInfo shareInstance].userInfoModel = userModel;
        }else
        {
            [[zHud shareInstance]showMessage:msg];
        }
        return;
    }
}

@end
