//
//  ALauchCollectionViewCell.h
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALauchCollectionViewCell : UICollectionViewCell

@property(strong,nonatomic)RACSubject * launchSignal;

@property(copy,nonatomic)NSDictionary * imagedic;


@end

NS_ASSUME_NONNULL_END
