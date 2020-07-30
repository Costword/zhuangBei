//
//  zBaoKuanCell.h
//  ZhuangBei
//
//  Created by aa on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^baokuanCellTap)(NSDictionary * sourceDic);

@interface zBaoKuanCell : UITableViewCell

+(zBaoKuanCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSArray * Array;

@property(copy,nonatomic)baokuanCellTap baokuanTapback;
@end

NS_ASSUME_NONNULL_END
