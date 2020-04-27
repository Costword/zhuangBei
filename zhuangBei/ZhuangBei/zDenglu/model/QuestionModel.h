//
//  QuestionModel.h
//  chose
//
//  Created by aa on 2019/12/2.
//  Copyright © 2019 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface QuestionModel : NSObject

@property(assign,nonatomic)NSInteger type;
@property(copy,nonatomic)NSString * name;//问题描述
@property(strong,nonatomic)NSArray * answers;

@property(assign,nonatomic)NSInteger QuestionIndex;
@end

NS_ASSUME_NONNULL_END
