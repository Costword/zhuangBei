//
//  LWBaseAlearView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/17.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAlearCustomManagerView : UIView

+ (instancetype)showAlearView:(UIView *)mainview;

- (void)dimiss;


@end

@interface LWAddNewUserGroupView : UIView

@property (weak, nonatomic) IBOutlet UITextField *tf;

@property (weak, nonatomic) IBOutlet UIButton *isDeflutBtn;

@end
NS_ASSUME_NONNULL_END
