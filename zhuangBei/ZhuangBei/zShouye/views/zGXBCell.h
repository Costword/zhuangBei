//
//  zGXBCell.h
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zGXDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface zGXBCell : UITableViewCell

+(zGXBCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)zGXDetailModel * model;

@end

NS_ASSUME_NONNULL_END
