//
//  zQuestionController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/26.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zQuestionController.h"
#import "QuestionHeaderView.h"
#import "AnswerCell.h"
#import "MJExtension.h"
#import "QuestionModel.h"
#import "AnswerModel.h"

static NSString * que = @"que";
static NSString * ans = @"ans";

@interface zQuestionController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSArray * queastionArray;
@property(strong,nonatomic)NSMutableArray * QuestionModelArray;

@property(strong,nonatomic)UITableView * questionTableView;
@property(strong,nonatomic)NSMutableArray * AnswerArray;//存放答案的数组
@property(strong,nonatomic)NSMutableDictionary * ansDic;//答案字典
@end

@implementation zQuestionController

-(NSArray*)queastionArray
{
    if (!_queastionArray) {
        NSArray * questionArray = @[
        @{
            @"type":@"1",
            @"name":@"我是一个单选题你怎么看",
            @"answers":
        @[@{
            @"chose":@"A",
            @"answer":@"完全赞同，"
        },
          @{ @"chose":@"B",
             @"answer":@"从理性的角度来看问题 你是一道单选题我的答案很长很长需要换行，换行换行换行换行话呐喊的那段难打"
          },
          @{ @"chose":@"C",
             @"answer":@"不容辩驳"
          },
          @{ @"chose":@"D",
             @"answer":@"你说是，那就是吧"
          }]},
        @{
              @"type":@"2",
              @"name":@"我是一道单选题，无论你觉得哪个答案是正确的都可以选择，我们会根据你所选择的正确答案的选项契合度打分，选错一项得分清零，请谨慎选择，祝你好运",
              @"answers":
          @[@{
              @"chose":@"A",
              @"answer":@"完全赞同"
          },
            @{ @"chose":@"B",
               @"answer":@"无论你觉得哪个答案是正确的都可以选择，我们会根据你所选择的正确答案的选项契合度打分，选错一项得分清零，请谨慎选择，祝你好运"
            },
            @{ @"chose":@"C",
               @"answer":@"不容辩驳"
            },
            @{ @"chose":@"D",
               @"answer":@"你说是，那就是吧"
            },
            @{ @"chose":@"E",
               @"answer":@"有一说一，确实"
            },
            @{ @"chose":@"F",
               @"answer":@"我就是来凑个热闹，你是什么我才不关心呢"
            }]}
          ];
        _queastionArray = questionArray;
    }
    return _queastionArray;
}


-(NSMutableArray*)QuestionModelArray
{
    if (!_QuestionModelArray) {
        _QuestionModelArray = [NSMutableArray array];
    }
    return _QuestionModelArray;
}

-(NSMutableArray*)AnswerArray
{
    if (!_AnswerArray) {
        _AnswerArray = [NSMutableArray array];
    }
    return _AnswerArray;
}

-(NSMutableDictionary*)ansDic
{
    if (!_ansDic) {
        _ansDic = [NSMutableDictionary dictionary];
        [_ansDic setObject:@"" forKey:que];
        [_ansDic setObject:@"" forKey:ans];
    }
    return _ansDic;
}

-(UITableView*)questionTableView
{
    if (!_questionTableView) {
        _questionTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _questionTableView.backgroundColor = [UIColor clearColor];
        _questionTableView.delegate = self;
        _questionTableView.dataSource = self;
        _questionTableView.estimatedRowHeight = 100;
        _questionTableView.showsVerticalScrollIndicator = NO;
        _questionTableView.rowHeight = UITableViewAutomaticDimension;
        _questionTableView.estimatedSectionHeaderHeight = 1;
        _questionTableView.estimatedSectionFooterHeight = 1;
        _questionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _questionTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.queastionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * dic = self.queastionArray[idx];
        QuestionModel * model = [QuestionModel mj_objectWithKeyValues:dic];
        model.QuestionIndex = idx;
        NSArray * answer = model.answers;
        
        NSMutableArray * answersModelArray = [NSMutableArray array];
        [answer enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger jdx, BOOL * _Nonnull stop) {
            NSDictionary * ansDic = [answer objectAtIndex:jdx];
            AnswerModel * answerModel = [AnswerModel mj_objectWithKeyValues:ansDic];
            answerModel.QuestionIndex = model.QuestionIndex;
            answerModel.AnswerIndex = jdx;
            [answersModelArray addObject:answerModel];
        }];
        model.answers = answersModelArray;
        [self.QuestionModelArray addObject:model];
    }];
    
    [self.view addSubview:self.questionTableView];
    [self updateViewConstraintsForView];
    
}

-(void)updateViewConstraintsForView
{
    [self.questionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.QuestionModelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QuestionModel * question =  self.QuestionModelArray[section];
    return question.answers.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerCell * answerCell = [AnswerCell creatTableViewCellWithTableView:tableView AndIndexPath:indexPath];
    QuestionModel * question =  self.QuestionModelArray[indexPath.section];
    answerCell.answerModel = question.answers[indexPath.row];
    __weak typeof(self)weakSelf = self;
    answerCell.upDataSelectAnswerBack = ^(AnswerModel * _Nonnull ansModel) {
        
        QuestionModel * Mquestion =  weakSelf.QuestionModelArray[ansModel.QuestionIndex];
        AnswerModel * Model = Mquestion.answers[ansModel.AnswerIndex];
        
        [weakSelf.ansDic setObject:@(Model.AnswerIndex) forKey:ans];
        [weakSelf.ansDic setObject:@(Model.QuestionIndex) forKey:que];
        
        if ([weakSelf.AnswerArray containsObject:weakSelf.ansDic]) {
            Model.ISCHOSE = NO;
            
//            NSMutableArray *arr = [NSMutableArray array];
//             NSDictionary *dic1 = weakSelf.ansDic;
//            NSMutableDictionary *dic11 = [[NSMutableDictionary alloc] initWithDictionary:dic1];
//            [arr addObject:dic1];
//             [arr addObject:dic11];
//              NSDictionary *dic2 = @{@"one":@12};
//              NSMutableDictionary *dic22 = [[NSMutableDictionary alloc] initWithDictionary:dic2];
//                BOOL bexist = [arr containsObject:dic2];  // 返回YES
//                bexist = [arr containsObject:dic22];    //返回YES
            
            [weakSelf.AnswerArray removeObject:weakSelf.ansDic];
        }else
        {
            Model.ISCHOSE = YES;
            [weakSelf.AnswerArray addObject:weakSelf.ansDic];
        }
        NSIndexPath * selceIndex = [NSIndexPath indexPathForRow:Model.AnswerIndex inSection:Model.QuestionIndex];
        [weakSelf.questionTableView reloadRowsAtIndexPaths:@[selceIndex] withRowAnimation:UITableViewRowAnimationNone];
    };
    return answerCell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuestionHeaderView * headerView = [[QuestionHeaderView alloc]init];
    QuestionModel * question =  self.QuestionModelArray[section];
    headerView.questionModel = question;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

@end
