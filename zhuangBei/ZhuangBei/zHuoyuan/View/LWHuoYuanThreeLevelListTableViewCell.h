//
//  LWHuoYuanThreeLevelListTableViewCell.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHuoYuanDaTingModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^clickItemsBlock)(gysListModel * model);
@interface LWHuoYuanThreeLevelListTableViewCell : UITableViewCell

@property (nonatomic, strong) LWHuoYuanThreeLevelModel * model;
@property (nonatomic, copy) clickItemsBlock clickItemsBlock;

@end

NS_ASSUME_NONNULL_END
