//
//  zShouyeTuiGuangCell.h
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/10.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface zShouyeTuiGuangCell : UITableViewCell

+(zShouyeTuiGuangCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSArray * sourceArray;

@end

NS_ASSUME_NONNULL_END
