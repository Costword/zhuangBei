//
//  zCategoryCell.h
//  ZhuangBei
//
//  Created by aa on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^categoryItemTap)(NSDictionary * dic);

@interface zCategoryCell : UITableViewCell

+(zCategoryCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSArray * Array;

@property(copy,nonatomic)categoryItemTap categoryTapBack;

@end

NS_ASSUME_NONNULL_END
