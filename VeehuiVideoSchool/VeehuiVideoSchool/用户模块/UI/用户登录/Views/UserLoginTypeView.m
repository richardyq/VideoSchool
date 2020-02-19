//
//  UserLoginTypeView.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/17.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "UserLoginTypeView.h"

@interface UserLoginTypeCell : UIControl

@property (nonatomic, readonly) EUserLoginType loginType;
@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* nameLabel;

- (id) initWithLoginType:(EUserLoginType) loginType;

@end

@implementation UserLoginTypeCell

- (id) initWithLoginType:(EUserLoginType) loginType{
    self = [super init];
    if (self) {
        _loginType = loginType;
        [self setCornerRadius:5];
        
        [self addTarget:self action:@selector(cellClickedDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(cellClickedUp) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(7.5);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-7.5);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(6);
        make.width.lessThanOrEqualTo(self).offset(5);
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [self addImageView];
        _iconImageView.image = [UIImage imageNamed:[self iconImageName]];
    }
    return _iconImageView;
}

- (UILabel*) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self addLabel:[UIColor commonTextColor] textSize:11];
        _nameLabel.text = [self typeName];
    }
    return _nameLabel;
}

- (NSString*) iconImageName{
    NSString* iconImageName = nil;
    switch (self.loginType) {
        case Login_Wechat:{
            iconImageName = @"icon_wechat";
            break;
        }
        case Login_Mobile:{
            iconImageName = @"icon_mobile";
            break;
        }
        default:
            break;
    }
    return iconImageName;
}

- (NSString*) typeName{
    NSString* typeName = nil;
    switch (self.loginType) {
        case Login_Wechat:{
            typeName = @"微信登录";
            break;
        }
        case Login_Mobile:{
            typeName = @"手机号登录";
            break;
        }
        default:
            break;
    }
    return typeName;
}

#pragma mark - control events
- (void) cellClickedDown{
    self.backgroundColor = [UIColor commonBoarderColor];
}

- (void) cellClickedUp{
    self.backgroundColor = [UIColor clearColor];
}

@end

@interface UserLoginTypeView ()

@property (nonatomic, strong) NSArray<UserLoginTypeCell*>* cells;
@property (nonatomic, copy) UserLoginTypeHandler loginTypeHandler;

@end

@implementation UserLoginTypeView

- (id) initWithLoginTypeHandler:(UserLoginTypeHandler) handler{
    self = [super init];
    if (self) {
        _loginTypeHandler = handler;
    }
    return self;
}

- (void) updateConstraints{
    [super updateConstraints];
    
    [self layoutLoginCells];
}

- (void) layoutLoginCells{
    __block MASViewAttribute* cellLeft = nil;
    [self.cells enumerateObjectsUsingBlock:^(UserLoginTypeCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(@72);
            if (!cellLeft) {
                make.left.equalTo(self).offset(15);
            }
            else{
                make.left.equalTo(cellLeft).offset(27);
            }
            if (cell == self.cells.lastObject) {
                make.right.equalTo(self).offset(-15);
            }
        }];
        cellLeft = cell.mas_right;
    }];
}

#pragma mark - settingAndGetting
- (NSArray<UserLoginTypeCell*>*) cells{
    if (!_cells) {
        NSMutableArray<UserLoginTypeCell*>* cells = [NSMutableArray<UserLoginTypeCell*> array];
        BOOL wechatInstalled = [[WechatUtil shareInstance] isWXAppInstalled];
         
        if (wechatInstalled) {
            UserLoginTypeCell* wechatLoginCell = [[UserLoginTypeCell alloc] initWithLoginType:Login_Wechat];
            [self addSubview:wechatLoginCell];
            [cells addObject:wechatLoginCell];
        }
        
        UserLoginTypeCell* mobileLoginCell = [[UserLoginTypeCell alloc] initWithLoginType:Login_Mobile];
        [self addSubview:mobileLoginCell];
        [cells addObject:mobileLoginCell];
        
        _cells = cells;
        
        
        [cells enumerateObjectsUsingBlock:^(UserLoginTypeCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
            [cell addTarget:self action:@selector(loginTypeCellClicked:) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
    return _cells;
    
}

#pragma mark - cell event
- (void) loginTypeCellClicked:(id) sender{
    UserLoginTypeCell* cell = (UserLoginTypeCell*) sender;
    if (![cell isKindOfClass:[UserLoginTypeCell class]]) {
        return;
    }
    
    if (self.loginTypeHandler) {
        self.loginTypeHandler(cell.loginType);
    }
}

@end
