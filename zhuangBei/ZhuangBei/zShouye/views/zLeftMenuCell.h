//
//  zLeftMenuCell.h
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zPersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface zLeftMenuCell : UITableViewCell

+(zLeftMenuCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)zPersonalModel * persoamModel;

@end

NS_ASSUME_NONNULL_END
