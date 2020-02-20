//
//  ListModel.h
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/2/20.
//  Copyright © 2020 殷全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject

@property (nonatomic) NSInteger pageNo;
@property (nonatomic) NSInteger pageSize;
@property (nonatomic) NSInteger totalElements;
@property (nonatomic) NSInteger totalPages;
@property (nonatomic) BOOL haveNextPage;

@property (nonatomic, strong) NSArray<EntryModel*>* content;
@end

NS_ASSUME_NONNULL_END
