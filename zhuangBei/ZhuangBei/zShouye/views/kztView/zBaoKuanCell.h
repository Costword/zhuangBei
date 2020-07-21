//
//  zBaoKuanCell.h
//  ZhuangBei
//
//  Created by aa on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface zBaoKuanCell : UITableViewCell

+(zBaoKuanCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSArray * Array;

@end

NS_ASSUME_NONNULL_END
