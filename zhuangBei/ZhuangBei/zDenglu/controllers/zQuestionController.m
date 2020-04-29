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

static NSString * quekey = @"questionId";
static NSString * ansList = @"optionList";
static NSString * anskey = @"optionId";

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
        [_ansDic setObject:@"" forKey:quekey];
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
    NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kQuestion];
    [self getData:NO url:url withParam:@{}];
    
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
    return question.optionList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerCell * answerCell = [AnswerCell creatTableViewCellWithTableView:tableView AndIndexPath:indexPath];
    QuestionModel * question =  self.QuestionModelArray[indexPath.section];
    answerCell.answerModel = question.optionList[indexPath.row];
    __weak typeof(self)weakSelf = self;
    answerCell.upDataSelectAnswerBack = ^(AnswerModel * _Nonnull ansModel) {
        
        QuestionModel * Mquestion =  weakSelf.QuestionModelArray[ansModel.QuestionIndex];
        AnswerModel * Model = Mquestion.optionList[ansModel.AnswerIndex];
        [weakSelf.ansDic setObject:@(Mquestion.questionId) forKey:quekey];
        NSMutableArray * ansArr = [NSMutableArray array];
        NSMutableDictionary * ansDic = [NSMutableDictionary dictionary];
        [ansDic setObject:@(Model.optionId) forKey:anskey];
        [ansArr addObject:ansDic];
        [weakSelf.ansDic setObject:ansArr forKey:ansList];
    
        //判断答案数组中是否有此选项，如果有，不做处理，没有则添加
        
        for (NSDictionary * dic in self.AnswerArray) {
            NSString * questionId = dic[quekey];
            if ([questionId integerValue] == Mquestion.questionId) {
                
                NSArray * ansA = dic[ansList];
                for (NSDictionary * ans in ansA) {
                    NSString * optionId = ans[anskey];
                    if ([optionId integerValue] == Model.optionId) {
                        //如果已经选中了
                        Model.ISCHOSE = YES;
                    }else
                    {
                        //未选中 先清零 再设置选中状态
                        [Mquestion.optionList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            AnswerModel * ansmodel = Mquestion.optionList[idx];
                            ansmodel.ISCHOSE = NO;
                        }];
                        Model.ISCHOSE = YES;
                    }
                }
            }
        }
        
//        [weakSelf.ansDic setObject:@(Model.QuestionIndex) forKey:que];
        
//        if ([weakSelf.AnswerArray containsObject:weakSelf.ansDic]) {
//            Model.ISCHOSE = NO;
//            [weakSelf.AnswerArray removeObject:weakSelf.ansDic];
//        }else
//        {
//            Model.ISCHOSE = YES;
//            [weakSelf.AnswerArray addObject:weakSelf.ansDic];
//        }
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

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kQuestion]) {
        [[zHud shareInstance]showMessage:@"获取试卷失败"];
        return;
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kQuestion]) {
        NSDictionary * dic = data;
        NSLog(@"获取试卷成功%@",dic);
        [[zHud shareInstance]showMessage:@"获取试卷成功"];
        
        NSArray * questionArray = dic[@"data"][@"questionList"][@"danxt"];
        
        [questionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = questionArray[idx];
            QuestionModel * model = [QuestionModel mj_objectWithKeyValues:dic];
            model.QuestionIndex = idx;
            NSArray * answer = model.optionList;
            
            NSMutableArray * answersModelArray = [NSMutableArray array];
            [answer enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger jdx, BOOL * _Nonnull stop) {
                NSDictionary * ansDic = [answer objectAtIndex:jdx];
                AnswerModel * answerModel = [AnswerModel mj_objectWithKeyValues:ansDic];
                answerModel.QuestionIndex = model.QuestionIndex;
                answerModel.AnswerIndex = jdx;
                [answersModelArray addObject:answerModel];
            }];
            model.optionList = answersModelArray;
            [self.QuestionModelArray addObject:model];
        }];
        [self.questionTableView reloadData];
    }
}


@end
