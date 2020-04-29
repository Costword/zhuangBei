//
//  AnswerModel.h
//  chose
//
//  Created by aa on 2019/12/2.
//  Copyright © 2019 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerModel : NSObject

@property(copy,nonatomic)NSString * isAnswer;//
@property(copy,nonatomic)NSString * optionName;//选项名
@property(assign,nonatomic)NSInteger optionId;
@property(assign,nonatomic)NSInteger questionId;
@property(assign,nonatomic)NSInteger optionNum;
@property(copy,nonatomic)NSString * createDate;//创建日期

@property(assign,nonatomic)NSInteger QuestionIndex;
@property(assign,nonatomic)NSInteger AnswerIndex;
@property(assign,nonatomic)BOOL ISCHOSE;//是否被选中
@end

NS_ASSUME_NONNULL_END
