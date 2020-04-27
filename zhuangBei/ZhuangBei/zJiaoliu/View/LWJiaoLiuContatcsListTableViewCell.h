//
//  LWJiaoLiuContatcsListTableViewCell.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//联系人 cell
@interface LWJiaoLiuContatcsListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * nameL;

@end

// 消息列表 cell
@interface LWJiaoLiuMessageListTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * nameL;
@property (nonatomic, strong) UIImageView * icon;
@end


typedef void(^clickSeactionBlock)(BOOL isShow);
// 联系人组头
@interface LWJiaoLiuContatcsSeactionView : UIView

@property (nonatomic, strong) UIImageView * leftIcon;
@property (nonatomic, strong) UILabel * leftL;
@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, copy) clickSeactionBlock block;
@end
NS_ASSUME_NONNULL_END
