//
//  MedicalGroupDetailFunction.m
//  VeehuiVideoSchool
//
//  Created by 殷全 on 2020/3/11.
//  Copyright © 2020 殷全. All rights reserved.
//

#import "MedicalGroupDetailFunction.h"
#import "MedicalVideoGroupDetailEntryModel.h"

@interface MedicalGroupDetailFunction ()

@property (nonatomic) NSInteger groupId;

@end

@implementation MedicalGroupDetailFunction

- (id) initWithGroupId:(NSInteger) groupId{
    self = [super init];
    if (self) {
        _groupId = groupId;
    }
    return self;
}

- (NSString*) requestUrl{
    return [NSString stringWithFormat:@"%@/v3/umv/medicalVideoGroupDetail/%ld", kURL_BASE_NEWDOMAIN, self.groupId];
}


- (NSDictionary*) reqeustDictionary{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:@(self.groupId) forKey:@"groupId"];
    
    return dict;
}

- (id) paraserResponse:(id) response{
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        MedicalVideoGroupDetailEntryModel* groupDetailModel = [MedicalVideoGroupDetailEntryModel mj_objectWithKeyValues:response];
        NSDictionary* groupDict = (NSDictionary*) response;
        NSArray<NSDictionary*>* videoDictionaries = [groupDict valueForKey:@"medicalVideoItems" ];
        NSMutableArray<MedicalVideoEntryModel*>* videoModels = [NSMutableArray<MedicalVideoEntryModel*> array];
        [videoDictionaries enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary* videoDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            NSDictionary* videoInfoDict = [dict valueForKey:@"videoInfo"];
            [videoDict addEntriesFromDictionary:videoInfoDict];
            [videoModels addObject:[MedicalVideoEntryModel mj_objectWithKeyValues:videoDict]];
        }];
        groupDetailModel.medicalVideoItems = videoModels;
        
        //currentMedicalVideoItem 当前播放视频
        NSDictionary* currentdict = [groupDict valueForKey:@"currentMedicalVideoItem"];
        if (!currentdict) {
            groupDetailModel.currentMedicalVideoItem = [videoModels firstObject];
        }
        else{
            
            NSMutableDictionary* videoDict = [NSMutableDictionary dictionaryWithDictionary:currentdict];
            NSDictionary* videoInfoDict = [currentdict valueForKey:@"videoInfo"];
            [videoDict addEntriesFromDictionary:videoInfoDict];
            groupDetailModel.currentMedicalVideoItem = [MedicalVideoEntryModel mj_objectWithKeyValues:videoDict];
        }
        
        return groupDetailModel;
    }
    return nil;
}
@end
