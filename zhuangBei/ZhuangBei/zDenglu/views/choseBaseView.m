//
//  choseBaseView.m
//  chose
//
//  Created by aa on 2019/12/2.
//  Copyright © 2019 aa. All rights reserved.
//

#import "choseBaseView.h"
#import "Masonry.h"
#import "AnswerCell.h"
#import "QuestionHeaderView.h"

@interface choseBaseView ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * choseTableView;

@property(strong,nonatomic)NSMutableArray * updateAnswerArray;

@end

@implementation choseBaseView

-(UITableView*)choseTableView
{
    if (!_choseTableView) {
        _choseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _choseTableView.backgroundColor = [UIColor clearColor];
        _choseTableView.delegate = self;
        _choseTableView.dataSource = self;
        _choseTableView.estimatedRowHeight = 100;
        _choseTableView.showsVerticalScrollIndicator = NO;
        _choseTableView.rowHeight = UITableViewAutomaticDimension;
        _choseTableView.estimatedSectionHeaderHeight = 1;
        _choseTableView.estimatedSectionFooterHeight = 1;
        _choseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _choseTableView;
}

-(NSMutableArray*)updateAnswerArray
{
    if (!_updateAnswerArray) {
        _updateAnswerArray = [NSMutableArray array];
    }
    return _updateAnswerArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.choseTableView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.choseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionModel.answers.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerCell * answerCell = [AnswerCell creatTableViewCellWithTableView:tableView AndIndexPath:indexPath];
    answerCell.answerModel = self.questionModel.answers[indexPath.row];
    return answerCell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuestionHeaderView * headerView = [[QuestionHeaderView alloc]init];
    headerView.questionModel = self.questionModel;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)setQuestionModel:(QuestionModel *)questionModel
{
    _questionModel = questionModel;
    [self.choseTableView reloadData];
    [self updateConstraintsForView];
}

-(void)updataAnsCellSelectWithCell:(AnswerCell*)cell
{
    if (self.questionModel.type==1) {
        //单选
        NSIndexPath * index = [self.choseTableView indexPathForCell:cell];
        AnswerModel * currentModel = self.questionModel.answers[index.row];
        //取出当前答案，如果已选中不作处理
        if (currentModel.ISCHOSE) {
            
        }else
        {
            if ([self.updateAnswerArray containsObject:currentModel]) {
                //不作处理
            }else
            {
                //重置其他选项的选中状态
                [self.questionModel.answers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    AnswerModel * othermodel = self.questionModel.answers[idx];
                    othermodel.ISCHOSE = NO;
                }];
                //先清空
                [self.updateAnswerArray removeAllObjects];
                currentModel.ISCHOSE = YES;
                [self.updateAnswerArray addObject:currentModel];
            }
        }
        [self.choseTableView reloadData];
    }else
    {
        //多选
        NSIndexPath * index = [self.choseTableView indexPathForCell:cell];
        AnswerModel * currentModel = self.questionModel.answers[index.row];
        //取出当前答案，如果已选中不作处理
        if (currentModel.ISCHOSE) {
            if ([self.updateAnswerArray containsObject:currentModel]) {
                //取消选中
                currentModel.ISCHOSE = NO;
                [self.updateAnswerArray removeObject:currentModel];
            }
        }else
        {
            //当前没选中
            if ([self.updateAnswerArray containsObject:currentModel]) {
                //不作处理
            }else
            {
                //添加选中
                currentModel.ISCHOSE = YES;
                [self.updateAnswerArray addObject:currentModel];
            }
        }
        [self.choseTableView reloadData];
        
    }
}

@end
