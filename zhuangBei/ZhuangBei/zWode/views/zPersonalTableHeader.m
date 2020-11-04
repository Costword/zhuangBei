//
//  zPersonalTableHeader.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/9/28.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zPersonalTableHeader.h"
#import "editTextField.h"
#import "zEducationRankTypeInfo.h"
#import "SelectedListView.h"
#import "zListTypeModel.h"
#import "phoneNumCheck.h"
#import "BLDatePickerView.h"

@interface zPersonalTableHeader ()<BLDatePickerViewDelegate>

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UITextField * textField;

@property(strong,nonatomic)editTextField * nameInputTextFild;//姓名

@property(strong,nonatomic)editTextField * sexInputTextFild;//性别

@property(strong,nonatomic)editTextField * phoneInputTextFild;//手机号

@property(strong,nonatomic)editTextField * birthdayInputTextFild;//出生日期

@property(strong,nonatomic)editTextField * emailInputTextFild;//邮箱

@property(strong,nonatomic)editTextField * jiguanInputTextFild;//籍贯

@property(strong,nonatomic)editTextField * xueliInputTextFild;//学历

@property(strong,nonatomic)editTextField * gongzuoInputTextFild;//工作年限

@property(strong,nonatomic)editTextField * gongsiInputTextFild;//公司名称

@property(strong,nonatomic)editTextField * gongsiTypeInputTextFild;//公司类型

@property(strong,nonatomic)editTextField * gongsiAddressInputTextFild;//公司所在省份

@property(strong,nonatomic)editTextField * bumenInputTextFild;//部门

@property(strong,nonatomic)editTextField * zhiwuInputTextFild;//职务

@property (nonatomic, strong) BLDatePickerView *datePickerView;

@property(strong,nonatomic)NSMutableArray * sexArray;
@property(strong,nonatomic)NSMutableArray * cityArray;
@property(strong,nonatomic)NSMutableArray * eduArray;
@property(strong,nonatomic)NSMutableArray * yearsArray;
@property(strong,nonatomic)NSMutableArray * comArray;
@property(strong,nonatomic)NSMutableArray * bumenArray;
@property(strong,nonatomic)NSMutableArray * zhiwuArray;

@end


@implementation zPersonalTableHeader

-(NSMutableArray*)sexArray
{
    if (!_sexArray) {
        _sexArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.sex enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.sex[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_sexArray addObject:selModel];
        }];
    }
    return _sexArray;
}

-(NSMutableArray*)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx  == 0) {
            }else
            {
                zListTypeModel * model = [zEducationRankTypeInfo shareInstance].citys[idx];
                SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
                [_cityArray addObject:selModel];
            }
        }];
    }
    return _cityArray;
}

-(NSMutableArray*)eduArray
{
    if (!_eduArray) {
        _eduArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.education enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.education[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_eduArray addObject:selModel];
        }];
    }
    return _eduArray;
}
-(NSMutableArray*)yearsArray
{
    if (!_yearsArray) {
        _yearsArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.jobYear enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.jobYear[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_yearsArray addObject:selModel];
        }];
    }
    return _yearsArray;
}

-(NSMutableArray*)comArray
{
    if (!_comArray) {
        _comArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.companyType enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.companyType[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_comArray addObject:selModel];
        }];
    }
    return _comArray;
}

-(NSMutableArray*)bumenArray
{
    if (!_bumenArray) {
        _bumenArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.section enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.section[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_bumenArray addObject:selModel];
        }];
    }
    return _bumenArray;
}

-(NSMutableArray*)zhiwuArray
{
    if (!_zhiwuArray) {
        _zhiwuArray = [NSMutableArray array];
        [[zEducationRankTypeInfo shareInstance].typesModel.rank enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            zListTypeModel * model = [zEducationRankTypeInfo shareInstance].typesModel.rank[idx];
            SelectedListModel * selModel = [[SelectedListModel alloc] initWithSid:[model.typeId integerValue] Title:model.name];
            [_zhiwuArray addObject:selModel];
        }];
    }
    return _zhiwuArray;
}


-(UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.userInteractionEnabled = YES;
    }
    return _baseView;
}

-(editTextField *)nameInputTextFild
{
    if (!_nameInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _nameInputTextFild = [[editTextField alloc]init];
        _nameInputTextFild.canTap = YES;
        _nameInputTextFild.canShow = NO;
        _nameInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _nameInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _nameInputTextFild.textAlignment = NSTextAlignmentRight;
        _nameInputTextFild.title = @"姓名（必填）";
        _nameInputTextFild.myPlaceHolder = @"请输入姓名";
        _nameInputTextFild.tapBack = ^{
            [LEEAlert alert].config
            .LeeTitle(@"修改姓名")
            .LeeAddTextField(^(UITextField * _Nonnull textField) {
                weakSelf.textField = textField;
            })
            .LeeCancelAction(@"取消", ^{
            })
            .LeeAction(@"确认", ^{
                // 点击事件Block
                if (weakSelf.textField.text.length>0) {
                    weakSelf.nameInputTextFild.text = weakSelf.textField.text;
//                    [weakSelf changeMyUpModel:nil];
                    weakSelf.upModel.userName = weakSelf.textField.text;
                    weakSelf.refresh = YES;
                }
            })
            .LeeShow();
        };
        _nameInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _nameInputTextFild;
}

-(editTextField *)sexInputTextFild
{
    if (!_sexInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _sexInputTextFild = [[editTextField alloc]init];
        _sexInputTextFild.canTap = YES;
        _sexInputTextFild.canShow = NO;
        _sexInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _sexInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _sexInputTextFild.textAlignment = NSTextAlignmentRight;
        _sexInputTextFild.title = @"性别（必填）";
        _sexInputTextFild.tapBack = ^{
            [weakSelf showSingleListWithTitl:@"选择性别" AndArray:weakSelf.sexArray AndeditTextField:weakSelf.sexInputTextFild];
        };
        _sexInputTextFild.eyesTapBack = ^(NSInteger show) {

        };
    }
    return _sexInputTextFild;
}

-(editTextField *)phoneInputTextFild
{
    if (!_phoneInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _phoneInputTextFild = [[editTextField alloc]init];
        _phoneInputTextFild.canTap = YES;
        _phoneInputTextFild.canShow = YES;
        _phoneInputTextFild.canEdit = YES;
        _phoneInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _phoneInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _phoneInputTextFild.textAlignment = NSTextAlignmentRight;
        _phoneInputTextFild.title = @"手机号码";
        _phoneInputTextFild.tapBack = ^{
            [LEEAlert alert].config
            .LeeTitle(@"修改手机号")
            .LeeAddTextField(^(UITextField * _Nonnull textField) {
                weakSelf.textField = textField;
                weakSelf.textField.keyboardType = UIKeyboardTypeNumberPad;
            })
            .LeeCancelAction(@"取消", ^{
                // 点击事件Block
            })
            .LeeAction(@"确认", ^{
                // 点击事件Block
                if (weakSelf.textField.text.length>0) {
                    BOOL rightNum = [phoneNumCheck validateMobile:weakSelf.textField.text];
                    if (rightNum) {
                        weakSelf.phoneInputTextFild.text = weakSelf.textField.text;
                        weakSelf.upModel.mobile = weakSelf.textField.text;
                        weakSelf.refresh = YES;
                    }else
                    {
                        [[zHud shareInstance]showMessage:@"请输入正确的手机号"];
                    }
                }
            })
            .LeeShow();
        };
        _phoneInputTextFild.eyesTapBack = ^(NSInteger show) {
            [zEducationRankTypeInfo shareInstance].userInfoModel.isShowMobile = show;
            weakSelf.upModel.isShowMobile = show;
            weakSelf.refresh = YES;
            if (weakSelf.changeModelBack) {
                weakSelf.changeModelBack(weakSelf.upModel,weakSelf.persoamModel);
            }
        };
    }
    return _phoneInputTextFild;
}

-(editTextField *)birthdayInputTextFild
{
    if (!_birthdayInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _birthdayInputTextFild = [[editTextField alloc]init];
        _birthdayInputTextFild.canTap = YES;
        _birthdayInputTextFild.canShow = YES;
        _birthdayInputTextFild.canEdit = NO;
        _birthdayInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _birthdayInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _birthdayInputTextFild.textAlignment = NSTextAlignmentRight;
        _birthdayInputTextFild.title = @"出生日期";
        _birthdayInputTextFild.tapBack = ^{
//            NSLog(@"点击选择出生日期");
            [weakSelf.datePickerView bl_show];
        };
        _birthdayInputTextFild.eyesTapBack = ^(NSInteger show) {
            [zEducationRankTypeInfo shareInstance].userInfoModel.isShowMobile = show;
            weakSelf.upModel.isShowBirth = show;
            weakSelf.refresh = YES;
            if (weakSelf.changeModelBack) {
                weakSelf.changeModelBack(weakSelf.upModel,weakSelf.persoamModel);
            }
        };
    }
    return _birthdayInputTextFild;
}

-(editTextField *)emailInputTextFild
{
    if (!_emailInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _emailInputTextFild = [[editTextField alloc]init];
        _emailInputTextFild.canTap = YES;
        _emailInputTextFild.canShow = NO;
        _emailInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _emailInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _emailInputTextFild.textAlignment = NSTextAlignmentRight;
        _emailInputTextFild.title = @"E-mail";
        _emailInputTextFild.tapBack = ^{
            [LEEAlert alert].config
            .LeeTitle(@"修改邮箱")
            .LeeAddTextField(^(UITextField * _Nonnull textField) {
                weakSelf.textField = textField;
            })
            .LeeCancelAction(@"取消", ^{
                // 点击事件Block
            })
            .LeeAction(@"确认", ^{
                // 点击事件Block
                if (weakSelf.textField.text.length>0) {
                    weakSelf.emailInputTextFild.text = weakSelf.textField.text;
                    weakSelf.upModel.email = weakSelf.textField.text;
                    weakSelf.refresh = YES;
                }
            })
            .LeeShow();
        };
        _emailInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _emailInputTextFild;
}
-(editTextField *)jiguanInputTextFild
{
    if (!_jiguanInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _jiguanInputTextFild = [[editTextField alloc]init];
        _jiguanInputTextFild.canTap = YES;
        _jiguanInputTextFild.canShow = NO;
        _jiguanInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _jiguanInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _jiguanInputTextFild.textAlignment = NSTextAlignmentRight;
        _jiguanInputTextFild.title = @"籍贯";
        _jiguanInputTextFild.tapBack = ^{
            [weakSelf showSingleListWithTitl:@"选择籍贯" AndArray:weakSelf.cityArray AndeditTextField:weakSelf.jiguanInputTextFild];
        };
        _jiguanInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _jiguanInputTextFild;
}

-(editTextField *)xueliInputTextFild
{
    if (!_xueliInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _xueliInputTextFild = [[editTextField alloc]init];
        _xueliInputTextFild.canTap = YES;
        _xueliInputTextFild.canShow = YES;
        _xueliInputTextFild.canEdit = NO;
        _xueliInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _xueliInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _xueliInputTextFild.textAlignment = NSTextAlignmentRight;
        _xueliInputTextFild.title = @"学历";
        _xueliInputTextFild.tapBack = ^{
            [weakSelf showSingleListWithTitl:@"选择学历" AndArray:weakSelf.eduArray AndeditTextField:weakSelf.xueliInputTextFild];
        };
        _xueliInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _xueliInputTextFild;
}

-(editTextField *)gongzuoInputTextFild
{
    if (!_gongzuoInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _gongzuoInputTextFild = [[editTextField alloc]init];
        _gongzuoInputTextFild.canTap = YES;
        _gongzuoInputTextFild.canShow = YES;
        _gongzuoInputTextFild.canEdit = NO;
        _gongzuoInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _gongzuoInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _gongzuoInputTextFild.textAlignment = NSTextAlignmentRight;
        _gongzuoInputTextFild.title = @"工作年限";
        _gongzuoInputTextFild.tapBack = ^{
            [weakSelf showSingleListWithTitl:@"选择工作年限" AndArray:weakSelf.yearsArray AndeditTextField:weakSelf.gongzuoInputTextFild];
        };
        _gongzuoInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _gongzuoInputTextFild;
}

-(editTextField *)gongsiInputTextFild
{
    if (!_gongsiInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _gongsiInputTextFild = [[editTextField alloc]init];
        _gongsiInputTextFild.canTap = YES;
        _gongsiInputTextFild.canShow = NO;
        _gongsiInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _gongsiInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _gongsiInputTextFild.textAlignment = NSTextAlignmentRight;
        _gongsiInputTextFild.title = @"公司名称";
        _gongsiInputTextFild.tapBack = ^{
            if (weakSelf.cantChange) {
                [[zHud shareInstance]showMessage: @"已认证企业不可修改"];
                return;
            }
            [LEEAlert alert].config
            .LeeTitle(@"修改企业名称")
            .LeeAddTextField(^(UITextField * _Nonnull textField) {
                weakSelf.textField = textField;
            })
            .LeeCancelAction(@"取消",nil)
            .LeeAction(@"确认", ^{
                if (weakSelf.textField.text.length>0) {
                    NSString * leixing =  weakSelf.textField.text;
                    weakSelf.upModel.suoShuGsName = leixing;
                    weakSelf.gongsiInputTextFild.text = [NSString stringWithFormat:@"%@",leixing];
                    weakSelf.refresh = YES;
                }
            })
            .LeeShow();
        };
        _gongsiInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _gongsiInputTextFild;
}

-(editTextField *)gongsiTypeInputTextFild
{
    if (!_gongsiTypeInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _gongsiTypeInputTextFild = [[editTextField alloc]init];
        _gongsiTypeInputTextFild.canTap = YES;
        _gongsiTypeInputTextFild.canShow = NO;
        _gongsiTypeInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _gongsiTypeInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _gongsiTypeInputTextFild.textAlignment = NSTextAlignmentRight;
        _gongsiTypeInputTextFild.title = @"公司类型";
        _gongsiTypeInputTextFild.tapBack = ^{
            if (weakSelf.cantChange) {
                [[zHud shareInstance]showMessage: @"已认证企业不可修改"];
                return;
            }
            [weakSelf showSingleListWithTitl:@"选择公司类型" AndArray:weakSelf.comArray AndeditTextField:weakSelf.gongsiTypeInputTextFild];
        };
        _gongsiTypeInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _gongsiTypeInputTextFild;
}

-(editTextField *)gongsiAddressInputTextFild
{
    if (!_gongsiAddressInputTextFild) {
//        __weak typeof(self)weakSelf = self;
        _gongsiAddressInputTextFild = [[editTextField alloc]init];
        _gongsiAddressInputTextFild.canTap = YES;
        _gongsiAddressInputTextFild.canShow = NO;
        _gongsiAddressInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _gongsiAddressInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _gongsiAddressInputTextFild.textAlignment = NSTextAlignmentRight;
        _gongsiAddressInputTextFild.title = @"公司所在省份（必选）";
        _gongsiAddressInputTextFild.tapBack = ^{
//            if (weakSelf.cantChange) {
//                [[zHud shareInstance]showMessage: @"已认证企业不可修改"];
//                return;
//            }
//            [weakSelf showSingleListWithTitl:@"选择公司所省份" AndArray:weakSelf.cityArray AndeditTextField:weakSelf.gongsiAddressInputTextFild];
        };
        _gongsiAddressInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _gongsiAddressInputTextFild;
}

-(editTextField *)bumenInputTextFild
{
    if (!_bumenInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _bumenInputTextFild = [[editTextField alloc]init];
        _bumenInputTextFild.canTap = YES;
        _bumenInputTextFild.canShow = NO;
        _bumenInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _bumenInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _bumenInputTextFild.textAlignment = NSTextAlignmentRight;
//        （必填）
        _bumenInputTextFild.title = @"部门";
        _bumenInputTextFild.tapBack = ^{
            if (weakSelf.cantChange) {
                [[zHud shareInstance]showMessage: @"已认证企业不可修改"];
                return;
            }
            [weakSelf showSingleListWithTitl:@"选择部门" AndArray:weakSelf.bumenArray AndeditTextField:weakSelf.bumenInputTextFild];
        };
        _bumenInputTextFild.eyesTapBack = ^(NSInteger show) {
//            [weakSelf showChange:show];
        };
    }
    return _bumenInputTextFild;
}

-(editTextField *)zhiwuInputTextFild
{
    if (!_zhiwuInputTextFild) {
        __weak typeof(self)weakSelf = self;
        _zhiwuInputTextFild = [[editTextField alloc]init];
        _zhiwuInputTextFild.canTap = YES;
        _zhiwuInputTextFild.canShow = NO;
        _zhiwuInputTextFild.icon = [UIImage imageNamed:@"blank"];
        _zhiwuInputTextFild.keyboardType = UIKeyboardTypeDefault;
        _zhiwuInputTextFild.textAlignment = NSTextAlignmentRight;
//        （必填）
        _zhiwuInputTextFild.title = @"职务";
        _zhiwuInputTextFild.tapBack = ^{
            if (weakSelf.cantChange) {
                [[zHud shareInstance]showMessage: @"已认证企业不可修改"];
                return;
            }
            [weakSelf showSingleListWithTitl:@"选择职务" AndArray:weakSelf.zhiwuArray AndeditTextField:weakSelf.zhiwuInputTextFild];
        };
        _zhiwuInputTextFild.eyesTapBack = ^(NSInteger show) {
        };
    }
    return _zhiwuInputTextFild;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.nameInputTextFild];
        [self.baseView addSubview:self.sexInputTextFild];
        [self.baseView addSubview:self.phoneInputTextFild];
        [self.baseView addSubview:self.birthdayInputTextFild];
        [self.baseView addSubview:self.emailInputTextFild];
        [self.baseView addSubview:self.jiguanInputTextFild];
        [self.baseView addSubview:self.jiguanInputTextFild];
        [self.baseView addSubview:self.xueliInputTextFild];
        [self.baseView addSubview:self.gongzuoInputTextFild];
        [self.baseView addSubview:self.gongsiInputTextFild];
        [self.baseView addSubview:self.gongsiTypeInputTextFild];
        [self.baseView addSubview:self.gongsiAddressInputTextFild];
        [self.baseView addSubview:self.bumenInputTextFild];
        [self.baseView addSubview:self.zhiwuInputTextFild];
        [self updateConstraintsForView];
        [self setdata];
    }
    return self;
}

-(void)setdata{
    self.nameInputTextFild.text = [zEducationRankTypeInfo shareInstance].userInfoModel.userName!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.userName:@"";
    
    NSString * sex =  [zEducationRankTypeInfo shareInstance].userInfoModel.sex!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.sex:@"";
    
    [self.sexArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedListModel * selModel = self.sexArray[idx];
        if ([sex isEqualToString:selModel.sid]) {
            //取出性别
            self.sexInputTextFild.text = selModel.title;
        }
    }];
    self.phoneInputTextFild.text = [zEducationRankTypeInfo shareInstance].userInfoModel.mobile!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.mobile:@"";
    self.birthdayInputTextFild.text = [zEducationRankTypeInfo shareInstance].userInfoModel.birth!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.birth:@"";
    self.emailInputTextFild.text = [zEducationRankTypeInfo shareInstance].userInfoModel.email!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.email:@"";
    
    NSString * jiguan = [zEducationRankTypeInfo shareInstance].userInfoModel.nativePlace!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.nativePlace:@"";
    [self.cityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedListModel * selModel = self.cityArray[idx];
        if ([jiguan isEqualToString:selModel.sid]) {
            //取出籍贯
            self.jiguanInputTextFild.text = selModel.title;
        }
    }];
    NSString * xueki = [zEducationRankTypeInfo shareInstance].userInfoModel.education!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.education:@"";
    
    [self.eduArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedListModel * selModel = self.eduArray[idx];
        if ([xueki isEqualToString:selModel.sid]) {
            //取出学历
            self.xueliInputTextFild.text = selModel.title;
        }
    }];
    
    NSString * gongzuonianxian = [zEducationRankTypeInfo shareInstance].userInfoModel.jobYear!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.jobYear:@"";
    [self.yearsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedListModel * selModel = self.yearsArray[idx];
        if ([gongzuonianxian isEqualToString:selModel.sid]) {
            //取出工作年限
            self.gongzuoInputTextFild.text = selModel.title;
        }
    }];
    
    
    self.gongsiInputTextFild.text = [zEducationRankTypeInfo shareInstance].userInfoModel.suoShuGsName!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.suoShuGsName:@"";
    
    NSString * leixing = [zEducationRankTypeInfo shareInstance].userInfoModel.companyType!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.companyType:@"";
    [self.comArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedListModel * selModel = self.comArray[idx];
        if ([leixing isEqualToString:selModel.sid]) {
            //取出性别
            self.gongsiTypeInputTextFild.text = selModel.title;
        }
    }];
    
    NSString * dizhi = [zEducationRankTypeInfo shareInstance].userInfoModel.regLocation!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.regLocation:@"";
    [self.cityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedListModel * selModel = self.cityArray[idx];
        if ([dizhi isEqualToString:selModel.sid]) {
            //取出性别
            self.gongsiAddressInputTextFild.text = selModel.title;
        }
    }];
    
    NSString * bumen =[zEducationRankTypeInfo shareInstance].userInfoModel.buMen!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.buMen:@"";
    [self.bumenArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedListModel * selModel = self.bumenArray[idx];
        if ([bumen isEqualToString:selModel.sid]) {
            //取出性别
            self.bumenInputTextFild.text = selModel.title;
        }
    }];
    
    NSString * zhiwu =[zEducationRankTypeInfo shareInstance].userInfoModel.post!=nil?[zEducationRankTypeInfo shareInstance].userInfoModel.post:@"";
    [self.zhiwuArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectedListModel * selModel = self.zhiwuArray[idx];
        if ([zhiwu isEqualToString:selModel.sid]) {
            //取出性别
            self.zhiwuInputTextFild.text = selModel.title;
        }
    }];
}

- (BLDatePickerView *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [[BLDatePickerView alloc] init];
        _datePickerView.pickViewDelegate = self;
        NSDate *date = [NSDate date];
        NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
        //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [forMatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [forMatter stringFromDate:date];
        NSLog(@"dateStr =  %@",dateStr);
        NSArray * array = [dateStr componentsSeparatedByString:@"-"];
        NSString * year = array[0];
        NSString * month = array[1];
        NSString * day = array[2];
        NSInteger yearintger = [year integerValue];
        NSInteger monthintger = [month integerValue];
        NSInteger dayinteger = [day integerValue];
        [_datePickerView bl_setUpDefaultDateWithYear:yearintger month:monthintger day:dayinteger];
        _datePickerView.topViewBackgroundColor = [UIColor colorWithHexString:@"#3F50B5"];
        /** 可设置的属性 */
//         /** 标题大小 */
//        @property (nonatomic, strong)UIFont  *titleFont;
//        /** 选择器背景颜色 */
//        @property (nonatomic, strong)UIColor *pickViewBackgroundColor;
//        /** 选择器头部视图颜色 */
//        @property (nonatomic, strong)UIColor *topViewBackgroundColor;
//        /** 取消按钮颜色 */
//        @property (nonatomic, strong)UIColor *cancelButtonColor;
//        /** 确定按钮颜色 */
//        @property (nonatomic, strong)UIColor *sureButtonColor;
//        /** 设置背景透明度 0~1 */
//        @property (nonatomic, assign)CGFloat backGAlpha;
        
    }
    return _datePickerView;
}

-(void)updateConstraintsForView
{
    
    CGFloat top = 0;
    CGFloat left = kWidthFlot(10);
    CGFloat right = -kWidthFlot(10);
    CGFloat height = kWidthFlot(50);
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.nameInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    
    [self.sexInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.phoneInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sexInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.birthdayInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.emailInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.birthdayInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.jiguanInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.xueliInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiguanInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.gongzuoInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.xueliInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.gongsiInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gongzuoInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.gongsiTypeInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gongsiInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.gongsiAddressInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gongsiTypeInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.bumenInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gongsiAddressInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
    }];
    [self.zhiwuInputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bumenInputTextFild.mas_bottom).offset(top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(right);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(-top);
    }];
}


-(void)setPersoamModel:(zPersonalModel *)persoamModel
{
    _persoamModel = persoamModel;
    
}

-(void)setUpModel:(zUpLoadUserModel *)upModel
{
    _upModel = upModel;
}

-(void)setTypesModel:(zTypesModel *)typesModel
{
    self.sexArray = nil;
    self.cityArray = nil;
    self.eduArray = nil;
    self.yearsArray = nil;
    self.comArray = nil;
    self.bumenArray = nil;
    self.zhiwuArray = nil;
    [self setdata];
}

-(void)showSingleListWithTitl:(NSString*)title AndArray:(NSArray*)array AndeditTextField:(editTextField*)myeditTextField
{
    __weak typeof(self) weakSelf = self;
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        
        [LEEAlert closeWithCompletionBlock:^{
            SelectedListModel * model = array[0];
            myeditTextField.text = model.title;
            if ([title containsString:@"性别"]) {
                weakSelf.upModel.sex = [NSString stringWithFormat:@"%@",model.sid];
            }
            if ([title containsString:@"籍贯"]) {
                // 籍贯传id
                weakSelf.upModel.nativePlace = [NSString stringWithFormat:@"%@",model.sid];
            }
            if ([title containsString:@"学历"]) {
                // 籍贯传id
                weakSelf.upModel.education = [NSString stringWithFormat:@"%@",model.sid];
            }
            if ([title containsString:@"工作年限"]) {
                // 籍贯传id
                weakSelf.upModel.jobYear = [NSString stringWithFormat:@"%@",model.sid];
            }
            if ([title containsString:@"公司类型"]) {
                // 籍贯传id
                weakSelf.upModel.companyType = [NSString stringWithFormat:@"%@",model.sid];
            }
            if ([title containsString:@"公司所在省份"]) {
                // 籍贯传id
                weakSelf.upModel.regLocation = [NSString stringWithFormat:@"%@",model.sid];
            }
            if ([title containsString:@"部门"]) {
                // 籍贯传id
                weakSelf.upModel.buMen = [NSString stringWithFormat:@"%@",model.sid];
            }
            if ([title containsString:@"职务"]) {
                // 籍贯传id
                weakSelf.upModel.post = [NSString stringWithFormat:@"%@",model.sid];
            }
            
            weakSelf.refresh = YES;
        }];
        
    };
    
    [LEEAlert alert].config
    .LeeTitle(title)
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    #ifdef __IPHONE_13_0
    .LeeUserInterfaceStyle(UIUserInterfaceStyleLight)
    #endif
    .LeeShow();
    
    view.array = array;
}

- (void)bl_selectedDateResultWithYear:(NSString *)year
                                month:(NSString *)month
                                  day:(NSString *)day{
    self.birthdayInputTextFild.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    
    self.upModel.birth = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    self.refresh = YES;
    
}

-(void)setCanEdit:(BOOL)canEdit
{
    if (canEdit) {
        self.userInteractionEnabled = YES;
    }else
    {
        self.userInteractionEnabled = NO;
    }
}

-(void)setCantChange:(BOOL)cantChange
{
    _cantChange = cantChange;
}

@end
