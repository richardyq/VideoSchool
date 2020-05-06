//
//  MeetingLivingSummaryTableViewCell.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/5/6.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MeetingLivingSummaryTableViewCell.h"
#import <WebKit/WebKit.h>
#import "MeetingDetailModel.h"
#import "MeetingScheduleTableViewCell.h"

@interface MeetingLivingSummaryTableViewCell ()
<WKNavigationDelegate>
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) WKWebView* contentWebview;
@property (nonatomic) CGFloat webHeight;
 
@end

@implementation MeetingLivingSummaryTableViewCell

- (void) updateConstraints{
    [super updateConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12.5);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.contentWebview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(11.);
    }];
    
}

#pragma mark - settingAndGetting
- (UILabel*) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [self.contentView addLabel:[UIColor commonTextColor] textSize:16 weight:UIFontWeightMedium];
        _titleLabel.text = @"会议介绍";
    }
    return _titleLabel;
}

- (WKWebView*) contentWebview{
    if (!_contentWebview) {
        _contentWebview = [[WKWebView alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 30)];
        [self.contentView addSubview:_contentWebview];
        _contentWebview.scrollView.scrollEnabled = NO;
        [_contentWebview sizeToFit];
        _contentWebview.navigationDelegate = self;
    }
    return _contentWebview;
}

- (void) setEntryModel:(EntryModel *)model{
    if (!model || ![model isKindOfClass:[MeetingDetailModel class]]) {
        return;
    }
    MeetingDetailModel* meeting = (MeetingDetailModel*) model;
    NSString *contentStr = [NSString stringWithFormat:@"<head><style>img{width:%f  !important;height:auto;}</style></head>%@",kScreenWidth - 50, meeting.summary];
     NSString *htmlHeader = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=no'></header>";
     //
     contentStr = [htmlHeader stringByAppendingString:contentStr];
    
     [self.contentWebview loadHTMLString:contentStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

- (void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.contentWebview sizeToFit];
    [self performSelector:@selector(loadHeight) withObject:self afterDelay:0.01];
}

- (void)loadHeight{
    CGFloat height = 0.0;
    
    height = self.contentWebview.scrollView.contentSize.height;
    CGFloat webWidth = self.contentWebview.scrollView.contentSize.width;
    CGFloat webHeight = height * ((self.contentView.width - 30) / webWidth);
    if (self.webHeight == webHeight) {
        return;
    }
     _webHeight = webHeight;
    [self.contentWebview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(11.);
        make.height.mas_equalTo(@(webHeight));
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:MeetingDetailContentLoadedNotification object:nil];
    
}

@end
