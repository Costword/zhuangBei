//
//  zjxsMenuCell.h
//  ZhuangBei
//  经销商目录
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zHuoYuanModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^menuSelectTapBack)(zHuoYuanModel * jxsModel);


@interface zjxsMenuCell : UITableViewCell

+(zjxsMenuCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)zHuoYuanModel * model;

@property(copy,nonatomic)menuSelectTapBack  selectTapBack;

@end

NS_ASSUME_NONNULL_END
