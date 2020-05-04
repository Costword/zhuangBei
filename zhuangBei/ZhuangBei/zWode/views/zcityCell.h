//
//  zcityCell.h
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zPersonalModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface zcityCell : UITableViewCell

+(zcityCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)zPersonalModel * persoamModel;

@property(assign,nonatomic)BOOL canEdit;

@end

NS_ASSUME_NONNULL_END
