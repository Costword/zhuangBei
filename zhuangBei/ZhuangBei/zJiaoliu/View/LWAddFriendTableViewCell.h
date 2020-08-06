//
//  LWAddFriendTableViewCell.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWAddFriendModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickBlock)(NSInteger tag);

@interface LWAddFriendTableViewCell : UITableViewCell

@property (nonatomic, strong) LWAddFriendModel * model;
@property (nonatomic, copy) ClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
